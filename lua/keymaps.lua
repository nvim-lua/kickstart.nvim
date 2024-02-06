vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Center after half-page down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Center after half-page up
vim.keymap.set('n', 'n', 'nzzzv') -- Center after next result
vim.keymap.set('n', 'N', 'Nzzzv') -- Center after previous result
vim.keymap.set('x', '<leader>p', [["_dP]]) -- Paste without losing register
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]]) -- Yank to OS clipboard
vim.keymap.set('n', '<leader>Y', [["+Y]]) -- ????
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]]) -- Delete without overwriting register
vim.keymap.set('n', '<leader>cm', vim.cmd.ZenMode, { desc = '[Z]en [M]ode' }) -- Toggle ZenMode

-- Harpoon
vim.keymap.set('n', '<leader>hm', require('harpoon.mark').add_file, { desc = '[m]ark file' })
vim.keymap.set('n', '<leader>ht', require('harpoon.ui').toggle_quick_menu, { desc = '[t]oggle quick menu' })
vim.keymap.set('n', '<leader>hd', require('harpoon.mark').rm_file, { desc = '[d]elete file' })
vim.keymap.set('n', '<M-h>', function()
  require('harpoon.ui').nav_file(1)
end, { desc = 'harpoon 1' })
vim.keymap.set('n', '<M-j>', function()
  require('harpoon.ui').nav_file(2)
end, { desc = 'harpoon 2' })
vim.keymap.set('n', '<M-k>', function()
  require('harpoon.ui').nav_file(3)
end, { desc = 'harpoon 3' })
vim.keymap.set('n', '<M-l>', function()
  require('harpoon.ui').nav_file(4)
end, { desc = 'harpoon 4' })
require('which-key').register {
  ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
}

-- Delete buffer
vim.keymap.set('n', '<leader>b', ':bd<CR>', { desc = 'Delete [b]uffer' })

-- Adjust split size
vim.keymap.set('n', '<C-Left>', ':vertical resize +3<CR>', { desc = 'Resize Pane Vertically <-' })
vim.keymap.set('n', '<C-Right>', ':vertical resize -3<CR>', { desc = 'Resize Pane Vertically ->' })

-- Move line up and down
vim.keymap.set('v', '<M-Up>', ":m '>+1<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set('v', '<M-Down>', ":m '>-2<CR>gv=gv", { desc = 'Move line down' })
