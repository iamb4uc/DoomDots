local augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Return to last edit position",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	desc = "Disable automatic comment continuation",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	desc = "Start native treesitter highlighting",
	pattern = {
		"lua",
		"vim",
		"vimdoc",
		"bash",
		"sh",
		"zsh",
		"markdown",
		"json",
		"yaml",
		"toml",
		"python",
		"go",
		"rust",
		"c",
		"cpp",
	},
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
