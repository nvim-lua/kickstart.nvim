return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>'),
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>'),
    vim.keymap.set('n', '<leader>x', '<Cmd>bprevious <bar> bd<CR>'),
}
