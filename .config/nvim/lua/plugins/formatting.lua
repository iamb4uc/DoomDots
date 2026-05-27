return {
	"stevearc/conform.nvim",

	event = {
		"BufWritePre",
	},

	cmd = {
		"ConformInfo",
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			python = { "isort", "black" },
			javascript = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},
			json = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},
			yaml = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},
			markdown = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
