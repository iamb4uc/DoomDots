return {
    "folke/todo-comments.nvim",

    event = {
        "BufReadPost",
        "BufNewFile",
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    opts = {
        signs = true,
        sign_priority = 8,

        keywords = {
            FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },

        gui_style = {
            fg = "BOLD",
            bg = "NONE",
        },

        merge_keywords = true,

        highlight = {
            multiline = true,
            multiline_pattern = "^.",
            multiline_context = 10,

            before = "",
            keyword = "wide",
            after = "fg",

            pattern = [[.*<(KEYWORDS)\s*:]],
            comments_only = true,
            max_line_len = 400,
            exclude = {},
        },

        colors = {
            error = { "DiagnosticError", "ErrorMsg" },
            warning = { "DiagnosticWarn", "WarningMsg" },
            info = { "DiagnosticInfo" },
            hint = { "DiagnosticHint" },
            default = { "Identifier" },
            test = { "DiagnosticOk", "Function", "Identifier" },
        },

        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]],
        },
    },
}
