-- ____________________  _______________ ______  __________
-- ____  _/__    |__   |/  /__  __ )_  // /_  / / /_  ____/
--  __  / __  /| |_  /|_/ /__  __  |  // /_  / / /_  /
-- __/ /  _  ___ |  /  / / _  /_/ //__  __/ /_/ / / /___
-- /___/  /_/  |_/_/  /_/  /_____/   /_/  \____/  \____/
-- A simpleton keymap config
-- github.com/iamb4uc for more software

local function map(m, k, v, desc)
	vim.keymap.set(m, k, v, { silent = true, desc = desc })
end

map("n", "<leader>fs", ":w<CR>", "Save file")
map("n", "<leader>fsa", ":wall<CR>", "Save all files")
map("n", "<leader>qq", ":q<CR>", "Quit")
map("n", "<leader>Qq", ":q!<CR>", "Force quit")
map("n", "<leader>fsq", ":x<CR>", "Save and quit")

-- Tab splits
map("n", "<leader>wc", "<C-w><C-c>", "Close window")
map("n", "<leader>l", "<C-w>l", "Move right")
map("n", "<leader>k", "<C-w>k", "Move up")
map("n", "<leader>j", "<C-w>j", "Move down")
map("n", "<leader>h", "<C-w>h", "Move left")

-- compiler stuff by The Tech gent Luke Smith
map("n", "<leader>a", ':! compiler "%:p"<CR><CR>', "Compile file")

-- cleanup script for any AI related resume writing, it cleans up citations
map("n", "<leader>A", ":! resume_checker %<CR>", "Check resume")

-- Open corresponding .pdf/.html or preview
map("n", "<leader>p", ':! opout "%:p" <CR><CR>', "Open output")

-- Open specific files
map("n", "<leader>oc", ":e ~/.config/nvim/<CR>", "Open Neovim config")
map("n", "<leader>sz", ":e ~/.config/zsh/.zshrc<CR>", "Open zshrc")
map("n", "<leader>la", ":Lazy<CR>", "Open Lazy")

map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("n", "<leader>y", "'+y", "Yank to clipboard")
map("n", "<leader>Y", "'+Y", "Yank line to clipboard")
map("v", "<leader>y", "'+y", "Yank to clipboard")
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], "Replace word")
