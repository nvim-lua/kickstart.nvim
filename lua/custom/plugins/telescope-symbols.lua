return {
    'nvim-telescope/telescope-symbols.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        vim.keymap.set('n', '<leader>ee', ':Telescope symbols<CR>', {})
    end,
}
