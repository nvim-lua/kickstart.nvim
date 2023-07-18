require('lualine').setup {
    options = {
        theme = 'tokyonight',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' ', right = ' ' },
    },
    extensions = {
        'trouble',
        'neo-tree',
        'nvim-dap-ui',
    },
}
