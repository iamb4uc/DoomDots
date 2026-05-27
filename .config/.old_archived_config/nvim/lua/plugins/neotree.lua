return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = true,
		window = {
			position = "right",
			width = 34,
			mappings = {
				["h"] = "close_node",
				["l"] = "open",
			},
		},
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = {
				enabled = true,
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
	},
}
