return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = vim.g.have_nerd_font,
                    theme = 'auto', -- Auto-detects catppuccin
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = { { 'filename', path = 1 } }, -- Show relative path
                    lualine_z = { '%2l:%-2v' }, -- Match previous LINE:COLUMN format
                },
            }
        end,
    },
}
