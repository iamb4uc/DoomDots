return {
    "lewis6991/gitsigns.nvim",

    event = {
        "BufReadPre",
        "BufNewFile",
    },

    cmd = {
        "Gitsigns",
    },

    opts = {
        signs = {
            add = {
                text = "+",
            },
            change = {
                text = "~",
            },
            delete = {
                text = "_",
            },
            topdelete = {
                text = "‾",
            },
            changedelete = {
                text = "~",
            },
        },

        current_line_blame = false,
    },
}
