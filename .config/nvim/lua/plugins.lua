-- Sets up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins.colorscheme" },
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    { import = "plugins.alpha" },
    { import = "plugins.lualine" },
    { import = "plugins.nvimtree" },
},  {
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
    checker = {
        enabled = true,
        notify = false,
    },
})

