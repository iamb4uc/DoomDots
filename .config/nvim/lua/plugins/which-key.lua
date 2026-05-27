return {
	"folke/which-key.nvim",

	event = "VeryLazy",

	opts = {
		preset = "classic",

		delay = 300,

		icons = {
			mappings = false,
		},

		win = {
			border = "rounded",
			padding = { 1, 2 },
		},
	},

	config = function(_, opts)
		local wk = require("which-key")

		wk.setup(opts)

		wk.add({
			{ "<leader>f", group = "file" },
			{ "<leader>l", group = "list/search" },
			{ "<leader>h", group = "help/hunk" },
			{ "<leader>g", group = "git" },
			{ "<leader>d", group = "diagnostics/document" },
			{ "<leader>x", group = "trouble" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>m", group = "mason" },
		})
	end,
}
