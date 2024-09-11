vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus" -- Syncs the system clipboard to nvim
vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true -- Enables 24bit colour support
vim.opt.numberwidth = 5
vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<cr>", { desc = "NvimTree Toggle", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ef", ":NvimTreeFocus<cr>", { desc = "NvimTree Focus", noremap = true, silent = true })
vim.keymap.set("n", "<leader>eF", ":NvimTreeFindFileToggle<cr>", { desc = "NvimTree Current", noremap = true, silent = true })
vim.keymap.set("n", "<leader>er", ":NvimTreeRefresh<cr>", { desc = "NvimTree Refresh", noremap = true, silent = true })
