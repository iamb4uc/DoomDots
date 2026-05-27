return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",

	dependencies = {
		"mason-org/mason.nvim",
	},

	cmd = {
		"MasonToolsInstall",
		"MasonToolsUpdate",
		"MasonToolsClean",
	},

	opts = {
		ensure_installed = {
			-- Formatters
			"stylua",
			"shfmt",
			"black",
			"isort",
			"prettier",

			-- Linters
			"shellcheck",
			"ruff",
			"eslint_d",
			"markdownlint",
		},

		auto_update = false,
		run_on_start = false,
	},
}
