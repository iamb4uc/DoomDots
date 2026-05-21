return {
	{
		"lervag/vimtex",
		ft = { "tex", "plaintex", "bib" },
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_syntax_enabled = 1
			vim.g.tex_flavor = "latex"
		end,
	},
}
