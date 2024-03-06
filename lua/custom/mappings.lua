local map = vim.keymap.set

map({ 'n' }, '<leader>cw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = '[C]ut [W]orld' })
map({ 'n' }, '<leader>x', '<cmd>bd<CR>', { desc = 'Close buffer' })
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
