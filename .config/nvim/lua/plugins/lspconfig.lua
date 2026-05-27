return {
	"neovim/nvim-lspconfig",

	event = {
		"BufReadPre",
		"BufNewFile",
	},

	dependencies = {
		"saghen/blink.cmp",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},

	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local ok, blink = pcall(require, "blink.cmp")
		if ok then
			capabilities = blink.get_lsp_capabilities(capabilities)
		end

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			root_dir = function(bufnr, on_dir)
				local file = vim.api.nvim_buf_get_name(bufnr)
				local nvim_config = vim.fn.stdpath("config")
				local home = vim.uv.os_homedir()

				if file:find(nvim_config, 1, true) == 1 then
					on_dir(nvim_config)
					return
				end

				local root = vim.fs.root(bufnr, { ".git" })

				if root and root ~= home then
					on_dir(root)
				end
			end,

			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = {
							"vim",
						},
					},
					workspace = {
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.config("bashls", {})
		vim.lsp.config("pyright", {})
		vim.lsp.config("gopls", {})
		vim.lsp.config("rust_analyzer", {})
		vim.lsp.config("jsonls", {})
		vim.lsp.config("yamlls", {})

		vim.lsp.enable({
			"lua_ls",
			"bashls",
			"pyright",
			"gopls",
			"rust_analyzer",
			"jsonls",
			"yamlls",
		})
	end,
}
