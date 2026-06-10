return {
    "nvim-mini/mini.pairs",

    version = false,
    event = "InsertEnter",

    config = function()
        require("mini.pairs").setup()
    end,
}
