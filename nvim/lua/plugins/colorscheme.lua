return {
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox-material")
            vim.o.background = "dark"

            vim.cmd("let g:gruvbox_material_background= 'hard'")
            vim.cmd("let g:gruvbox_material_diagnostic_line_highlight=1")
            vim.cmd("let g:gruvbox_material_diagnostic_virtual_text='colored'")
            vim.cmd("let g:gruvbox_material_enable_bold=1")
            vim.cmd("let g:gruvbox_material_enable_italic=1")

            vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
        end,
    },
}

