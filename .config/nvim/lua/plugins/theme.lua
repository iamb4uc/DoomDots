return {
	"ellisonleao/gruvbox.nvim",

	lazy = false,
	priority = 1000,

	opts = {
		terminal_colors = true,
		transparent_mode = true,
	},

	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd.colorscheme("gruvbox")
	end,
}
