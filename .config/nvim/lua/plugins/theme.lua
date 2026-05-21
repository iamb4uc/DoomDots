-------------
-- GRUVBOX --
-------------
return {
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
}
