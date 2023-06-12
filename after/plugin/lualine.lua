require('lualine').setup {
    options = {
        theme = 'tokyonight',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' ', right = ' ' },
    },
    extensions = {
        'toggleterm',
        'trouble',
        'neo-tree',
        'nvim-dap-ui',
    },
}
