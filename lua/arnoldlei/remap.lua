vim.g.mapleader = ' '
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Window splits
vim.keymap.set('n', '|', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '_', '<cmd>split<CR>', { desc = 'Split window horizontally' })

-- Window navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

vim.keymap.set('n', '<leader>vpp', '<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>')
vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>')

vim.keymap.set('n', '<leader>sf', ':source $HOME/.config/nvim/init.lua <CR>', { desc = 'Source Neovim config' })

-- Jump to beginning/end of method
vim.keymap.set('n', '[m', '[m', { desc = 'Jump to beginning of method' })
vim.keymap.set('n', ']m', ']m', { desc = 'Jump to end of method' })

-- Diagnostic navigation with float
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float()
end, { desc = 'Go to previous diagnostic' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next()
  vim.diagnostic.open_float()
end, { desc = 'Go to next diagnostic' })
