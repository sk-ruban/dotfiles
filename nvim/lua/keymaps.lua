vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>ee", ":NvimTreeToggle<cr>", { desc = "NvimTree Toggle", noremap = true, silent = true })
keymap.set("n", "<leader>ef", ":NvimTreeFocus<cr>", { desc = "NvimTree Focus", noremap = true, silent = true })
keymap.set("n", "<leader>eF", ":NvimTreeFindFileToggle<cr>", { desc = "NvimTree Current", noremap = true, silent = true })
keymap.set("n", "<leader>er", ":NvimTreeRefresh<cr>", { desc = "NvimTree Refresh", noremap = true, silent = true })

-- Windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
