local vo = vim.opt
local vg = vim.g
local vd = vim.diagnostic

vg.mapleader = " "
vg.maplocalleader = "\\"

vo.backup = false
vo.breakindent = true
vo.clipboard = "unnamedplus"
vo.completeopt = { "menu", "menuone", "noselect", "popup" }
vo.cursorline = true
vo.expandtab = true
vo.hlsearch = false
vo.ignorecase = true
vo.inccommand = "split"
vo.incsearch = true
vo.linebreak = true
vo.number = true
vo.relativenumber = true
vo.scrolloff = 8
vo.shiftwidth = 4
vo.showmode = false
vo.sidescrolloff = 8
vo.signcolumn = "yes"
vo.smartcase = true
vo.smartindent = true
vo.softtabstop = 4
vo.splitbelow = true
vo.splitright = true
vo.swapfile = false
vo.tabstop = 4
vo.termguicolors = true
vo.timeoutlen = 400
vo.undofile = true
vo.updatetime = 250
vo.wrap = false

vd.config({
    virtual_text = {
        source = "if_many",
        prefix = "* ",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})
