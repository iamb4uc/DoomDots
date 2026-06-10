return {
    "nvim-mini/mini.statusline",

    version = false,
    event = {
        "BufReadPost",
        "BufNewFile",
    },

    config = function()
        require("mini.statusline").setup({
            use_icons = true,
        })
    end,
}
