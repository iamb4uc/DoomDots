local function map(m, k, v, desc)
    vim.keymap.set(m, k, v, { silent = true, desc = desc })
end

local function isMiniOpen()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)

        if vim.bo[buf].filetype == "minifiles" then
            return true
        end
    end

    return false
end

map("n", "<leader>fs", ":w<CR>", "Save file")
map("n", "<leader>fsa", ":wall<CR>", "Save all files")
map("n", "<leader>qq", ":q<CR>", "Quit")
map("n", "<leader>qf", ":q!<CR>", "Force quit")
map("n", "<leader>fsq", ":x<CR>", "Save and quit")

-- Tab splits
map("n", "<leader>|", ":vsplit<cr>", "create vertical split")
map("n", "<leader>-", ":split<cr>", "create horizontal split")

map("n", "<leader>wc", "<C-w>c", "Close window")
map("n", "<C-l>", "<C-w>l", "Move right")
map("n", "<C-k>", "<C-w>k", "Move up")
map("n", "<C-j>", "<C-w>j", "Move down")
map("n", "<C-h>", "<C-w>h", "Move left")

-- Buffers
map("n", "H", ":bprevious<CR>", "Previous buffer")
map("n", "L", ":bnext<CR>", "Next buffer")
map("n", "<leader>bd", ":bdelete<CR>", "Delete buffer")

map("n", "<leader>a", ':! compiler "%:p"<CR><CR>', "Compile file")

-- Open corresponding .pdf/.html or preview
map("n", "<leader>p", ':! opout "%:p" <CR><CR>', "Open output")

-- Open specific files
map("n", "<leader>oc", ":e ~/.config/nvim/<CR>", "Open Neovim config")
map("n", "<leader>sz", ":e ~/.config/zsh/.zshrc<CR>", "Open zshrc")
map("n", "<leader>la", ":Lazy<CR>", "Open Lazy")

map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("n", "<leader>y", '"+y', "Yank to clipboard")
map("n", "<leader>Y", '"+Y', "Yank line to clipboard")
map("v", "<leader>y", '"+y', "Yank to clipboard")
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], "Replace word")

-- Application Key maps

-- Mini File browser key mapps
map("n", "<leader>e", function()
    local mf = require("mini.files") -- iykyk

    if isMiniOpen() then
        mf.close()
        return
    end

    local path = vim.api.nvim_buf_get_name(0)

    if path == "" then
        path = vim.uv.cwd()
    end

    mf.open(path, true)
end, "Toggle file explorer")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<cr>", "Find files")
map("n", "<leader><leader>", ":Telescope find_files<cr>", "Find files")
map("n", "<leader>lg", ":Telescope live_grep<cr>", "Live Grep")
map("n", "<leader>bb", ":Telescope buffers<cr>", "List Buffers")
map("n", "<leader>ht", ":Telescope help_tags<cr>", "Help Tags")
map("n", "<leader>of", ":Telescope oldfiles<cr>", "Old files")
map("n", "<leader>/", ":Telescope grep_string<cr>", "Find word under cursor")
map("n", "<leader>kk", ":Telescope keymaps<cr>", "Find keymaps")
map("n", "<leader>fd", ":Telescope diagnostics<cr>", "Find diagnostics")
map("n", "<leader>ds", ":Telescope lsp_document_symbols<cr>", "Document Symbols")
map("n", "<leader>gc", ":Telescope git_commits<cr>", "Git Commits")
map("n", "<leader>gs", ":Telescope git_status<cr>", "Git status")
-- map("n", "<leader>", ":Telescope ", "")

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_keymaps", {
        clear = true,
    }),
    callback = function(args)
        local function lsp_map(mode, key, action, desc)
            vim.keymap.set(mode, key, action, {
                buffer = args.buf,
                silent = true,
                desc = desc,
            })
        end

        lsp_map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        lsp_map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        lsp_map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        lsp_map("n", "gr", vim.lsp.buf.references, "Go to references")
        lsp_map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        lsp_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        lsp_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    end,
})

-- Diagnostics
map("n", "[d", ":lua vim.diagnostic.jump({ count = -1, float = true })<CR>", "Previous diagnostic")
map("n", "]d", ":lua vim.diagnostic.jump({ count = 1, float = true })<CR>", "Next diagnostic")
map("n", "<leader>dd", ":lua vim.diagnostic.open_float()<CR>", "Line diagnostics")
map("n", "<leader>dl", ":lua vim.diagnostic.setloclist()<CR>", "Diagnostics location list")

-- Formatting
map("n", "<leader>fm", ":lua require('conform').format({ async = true, lsp_format = 'fallback' })<CR>", "Format file")

-- Git
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", "Preview hunk")
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", "Stage buffer")
map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", "Reset buffer")
map("n", "<leader>hb", ":Gitsigns blame_line<CR>", "Blame line")
map("n", "<leader>hd", ":Gitsigns diffthis<CR>", "Diff this")

-- Trouble
map("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", "Trouble diagnostics")
map("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>", "Trouble buffer diagnostics")
map("n", "<leader>xs", ":Trouble symbols toggle focus=false<CR>", "Trouble symbols")
map("n", "<leader>xl", ":Trouble lsp toggle focus=false win.position=right<CR>", "Trouble LSP")
map("n", "<leader>xq", ":Trouble qflist toggle<CR>", "Trouble quickfix")

-- whichkey
map("n", "<leader>?", ":WhichKey<CR>", "Show keymaps")

-- term
map("n", "<leader>tt", ":ToggleTerm direction=float<CR>", "Toggle floating terminal")
map("n", "<leader>t-", ":ToggleTerm direction=horizontal size=12<CR>", "Toggle horizontal terminal")
map("n", "<leader>t|", ":ToggleTerm direction=vertical size=80<CR>", "Toggle vertical terminal")
map("n", "<leader>ta", ":ToggleTermToggleAll<CR>", "Toggle all terminals")

map("t", "<Esc>", "<C-\\><C-n>", "Terminal normal mode")
map("t", "<leader>tt", "<C-\\><C-n>:ToggleTerm direction=float<CR>", "Toggle floating terminal")

map("t", "<C-h>", "<C-\\><C-n><C-w>h", "Move to left window")
map("t", "<C-j>", "<C-\\><C-n><C-w>j", "Move to lower window")
map("t", "<C-k>", "<C-\\><C-n><C-w>k", "Move to upper window")
map("t", "<C-l>", "<C-\\><C-n><C-w>l", "Move to right window")

-- zenmode
map("n", "<leader>zz", ":ZenMode<CR>", "Toggle zen mode")

-- flash
map("n", "s", ":lua require('flash').jump()<CR>", "Flash jump")
map("n", "S", ":lua require('flash').treesitter()<CR>", "Flash treesitter")
