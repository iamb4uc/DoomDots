return {
	"mfussenegger/nvim-lint",

	event = {
		"BufReadPost",
		"BufWritePost",
		"InsertLeave",
	},

	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			sh = {
				"shellcheck",
			},

			bash = {
				"shellcheck",
			},

			zsh = {
				"shellcheck",
			},

			python = {
				"ruff",
			},

			javascript = {
				"eslint_d",
			},

			typescript = {
				"eslint_d",
			},

			markdown = {
				"markdownlint",
			},
		}

		local group = vim.api.nvim_create_augroup("user_linting", {
			clear = true,
		})

		vim.api.nvim_create_autocmd({
			"BufReadPost",
			"BufWritePost",
			"InsertLeave",
		}, {
			group = group,
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
