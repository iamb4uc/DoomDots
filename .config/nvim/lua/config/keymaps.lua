-- ____________________  _______________ ______  __________
-- ____  _/__    |__   |/  /__  __ )_  // /_  / / /_  ____/
--  __  / __  /| |_  /|_/ /__  __  |  // /_  / / /_  /
-- __/ /  _  ___ |  /  / / _  /_/ //__  __/ /_/ / / /___
-- /___/  /_/  |_/_/  /_/  /_____/   /_/  \____/  \____/
-- A simpleton keymap config
-- github.com/iamb4uc for more software

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<leader>fs", ":w<CR>")
map("n", "<leader>fsa", ":wall<CR>")
map("n", "<leader>qq", ":q<CR>")
map("n", "<leader>Qq", ":q!<CR>")
map("n", "<leader>fsq", ":x<CR>")

-- Tab splits
map("n", "<leader>sc", "<C-w><C-c>")
map("n", "<leader>l", "<C-w>l")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>h", "<C-w>h")

-- compiler stuff by The Tech gent Luke Smith
map("n", "<leader>a", ':! compiler "%:p"<CR><CR>')

-- cleanup script for any AI related resume writing, it cleans up citations
map("n", "<leader>A", ":! resume_checker %<CR>")

-- Open corresponding .pdf/.html or preview
map("n", "<leader>p", ':! opout "%:p" <CR><CR>')

-- Open specific files
map("n", "<leader>oc", ":e ~/.config/nvim/<CR>")
map("n", "<leader>sc", ":e ~/.config/zsh/.zshrc<CR>")
map("n", "<leader>la", ":Lazy<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>y", "'+y")
map("n", "<leader>Y", "'+Y")
map("v", "<leader>y", "'+y")
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])

-- Change NeoTree Layout
map("n", "<leader>Y", "'+Y")
