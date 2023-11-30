require('gopher').setup {
  commands = {
    go = 'go',
    gomodifytags = 'gomodifytags',
    gotests = '~/go/bin/gotests', -- also you can set custom command path
    impl = 'impl',
    iferr = 'iferr',
  },
}

vim.keymap.set('n', 'gaj', ':GoTagAdd json<CR>', { desc = 'Add JSON Tag TO Go Struct' })
vim.keymap.set('n', 'gax', ':GoTagAdd xml<CR>', { desc = 'Add XML Tag TO Go Struct' })
