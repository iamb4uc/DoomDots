return {
	"folke/zen-mode.nvim",
	cmd = { "ZenMode" },
	opts = {
		window = {
			backdrop = 1,
			width = 0.65,
			height = 0.90,

			options = {
				signcolumn = "no",
				number = false,
				relativenumber = false,
				cursorline = false,
				cursorcolumn = false,
			},
		},

		plugins = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 0,
			},
			twilight = { enabled = false },
			gitsigns = { enabled = false },
			tmux = { enabled = false },
			todo = { enabled = false },
		},
		on_open = function(_) end,
		on_close = function() end,
	},
}
