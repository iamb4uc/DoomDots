return {
	"nvim-telescope/telescope.nvim",
	version = "*",

	cmd = "Telescope",

	dependencies = {
		"nvim-lua/plenary.nvim",

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "❯ ",
				path_display = { "smart" },

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<Esc>"] = actions.close,
					},

					n = {
						["q"] = actions.close,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
					},
				},
			},

			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
	end,
}
