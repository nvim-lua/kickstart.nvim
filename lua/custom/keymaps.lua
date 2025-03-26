vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<Esc>')

-- Normal --
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Navigate buffers
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- diagnostics
vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Show diagnostic float' })

-- Files
vim.keymap.set('n', '<leader>q', '<cmd>q!<cr>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>.', '<cmd>luafile %<CR>', { desc = 'Source Lua file' })
vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment line' })
vim.keymap.set('v', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment for selection' })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete character without yanking' })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and stay in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and stay in visual mode' })

-- buffers
vim.keymap.set('n', '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Close buffers to the left' })
vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCloseRight<cr>', { desc = 'Close buffers to the right' })
vim.keymap.set('n', '<leader>bf', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>c', '<cmd>Bdelete!<CR>', { desc = 'Close buffer' })

--- lsp
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code actions' })
vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{async = true}<cr>', { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol' })
