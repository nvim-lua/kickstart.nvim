return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    opts = {buffer = 0},
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]]),
    vim.keymap.set('n', '<space>v', '<Cmd>ToggleTerm<CR>'),
}
