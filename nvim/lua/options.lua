local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Split Windows
opt.splitbelow = true
opt.splitright = true

-- Tabs & Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.wrap = false

-- Clipboard
opt.clipboard = "unnamedplus"
opt.scrolloff = 999

opt.virtualedit = "block"
opt.inccommand = "split"

-- Search Settings
opt.ignorecase = true

opt.termguicolors = true 
opt.cmdheight = 0
opt.laststatus = 3
opt.signcolumn = "yes"
