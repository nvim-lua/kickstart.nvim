return {
    {
        'akinsho/bufferline.nvim',
        config = function()
            require("bufferline").setup {
                options = {
                    indicator = { style = "icon", icon = "▎" },
                    diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
                    diagnostics_update_in_insert = false,
                    offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
                    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
                    always_show_bufferline = true,
                }
            }
        end
    }
}
