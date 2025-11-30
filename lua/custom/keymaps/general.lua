-- General keymaps for navigation, editing, and window management

-- Exit insert mode with jj
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })

-- Split management
vim.keymap.set('n', 'sj', '<C-W>w', { desc = 'Move to next window' })
vim.keymap.set('n', 'sk', '<C-W>W', { desc = 'Move to previous window' })
vim.keymap.set('n', 'su', ':resize +5<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', 'si', ':resize -5<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', 'sh', ':vertical resize +5<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', 'sl', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', 'sd', ':hide<CR>', { desc = 'Hide current window' })
vim.keymap.set('n', 'so', ':', { desc = 'Open command mode' })
vim.keymap.set('n', 'ss', ':split ', { desc = 'Horizontal split' })
vim.keymap.set('n', 'sv', ':vsplit ', { desc = 'Vertical split' })

-- Tab management
vim.keymap.set('n', 'th', ':tabfirst<CR>', { desc = 'Go to first tab' })
vim.keymap.set('n', 'tj', ':tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', 'tk', ':tabprev<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', 'tl', ':tablast<CR>', { desc = 'Go to last tab' })
vim.keymap.set('n', 'tt', ':tabedit ', { desc = 'Create new tab' })
vim.keymap.set('n', 'tn', ':tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', 'tm', ':tabm ', { desc = 'Move tab' })
vim.keymap.set('n', 'td', ':tabclose<CR>', { desc = 'Close tab' })

-- Buffer management
vim.keymap.set('n', '<C-k>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-j>', ':bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Close current buffer' })

-- Python debugging
vim.keymap.set('n', '<leader>p', 'oimport ipdb; ipdb.set_trace()<Esc>', { desc = 'Insert Python debugger breakpoint' })
