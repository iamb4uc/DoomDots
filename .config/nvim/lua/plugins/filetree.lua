return {
    "nvim-mini/mini.files",
    version = false,

    opts = {
        options = {
            use_as_default_explorer = true,
            permanent_delete = false,
        },

        windows = {
            preview = true,
            width_focus = 30,
            width_nofocus = 18,
            width_preview = 67, -- six seven
        },

        mappings = {
            close = "q",
            go_in = "l",
            go_in_plus = "<CR>",
            go_out = "h",
            go_out_plus = "H",
            reset = "<BS>",
            reveal_cwd = ".",
            show_help = "g?",
            synchronize = "s",
            trim_left = "<",
            trim_right = ">",
        },
    },
}
