return {
	"nvim-telescope/telescope.nvim",
	version = "*",

	cmd = { "Telescope" },

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
						["<Esc>"] = function(_)
							vim.cmd("stopinsert")
						end,

						["<C-c>"] = actions.close,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
					},

					n = {
						["q"] = actions.close,
						["<Esc>"] = actions.close,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,

						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-d>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,

						["<CR>"] = actions.select_default,
						["<C-v>"] = actions.select_vertical,
						["<C-x>"] = actions.select_horizontal,
						["<C-t>"] = actions.select_tab,

						["?"] = actions.which_key,
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
