return {
    "akinsho/toggleterm.nvim",

    version = "*",
    cmd = {
        "ToggleTerm",
        "TermExec",
    },

    opts = {
        size = 12,

        open_mapping = nil,

        hide_numbers = true,
        shade_terminals = false,

        start_in_insert = true,
        insert_mappings = false,
        terminal_mappings = false,

        persist_size = true,
        persist_mode = true,

        direction = "float",
        close_on_exit = true,

        shell = vim.o.shell,

        float_opts = {
            border = "rounded",
            width = function()
                return math.floor(vim.o.columns * 0.85)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
        },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)
    end,
}
