return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",

		opts = {
			ui = {
				border = "rounded",
			},
		},

		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"jsonls",
				"yamlls",
			},
			automatic_enable = false,
		},

		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
}
