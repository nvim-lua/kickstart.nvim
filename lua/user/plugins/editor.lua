-- [[ Editing and navigation ]]

-- Icons for oil and render-markdown
require('mini.icons').setup {}

-- Oil: file manager as a buffer, toggled with <leader>e
require('oil').setup {}
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    require('oil').open()
  end
end, { desc = 'Toggle Oil file manager' })

-- Flash: jump anywhere with a few keystrokes
require('flash').setup {
  modes = {
    char = {
      enabled = false, -- keep the normal f/F/t/T motions
    },
  },
}
vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('flash').jump()
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })

-- Smooth scrolling on [[ and ]]
local neoscroll = require 'neoscroll'
neoscroll.setup {}
vim.keymap.set({ 'n', 'v', 'x' }, '[[', function()
  neoscroll.ctrl_u { duration = 250 }
end, { desc = 'Scroll up' })
vim.keymap.set({ 'n', 'v', 'x' }, ']]', function()
  neoscroll.ctrl_d { duration = 250 }
end, { desc = 'Scroll down' })

-- Maximize a split (vim-maximizer)
vim.keymap.set('n', '<leader>wm', '<cmd>MaximizerToggle<CR>', { desc = 'Maximize/minimize a split' })

-- Sessions
require('persistence').setup {}
vim.keymap.set('n', '<leader>wr', function()
  require('persistence').load()
end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>wl', function()
  require('persistence').load { last = true }
end, { desc = 'Restore Last Session' })
vim.keymap.set('n', '<leader>wd', function()
  require('persistence').stop()
end, { desc = "Don't Save Current Session" })

-- Move between Neovim splits and tmux panes with <C-h/j/k/l>
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Window/pane left' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Window/pane down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Window/pane up' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Window/pane right' })

-- nvim-align and vim-startuptime need no setup
