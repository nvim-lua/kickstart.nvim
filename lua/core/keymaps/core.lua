---@diagnostic disable: undefined-global
-- Core Neovim keymaps (non-plugin)

return {
  -- Quick access to find files by content
  { mode = 'n', lhs = '<leader><space>', rhs = function() require('telescope.builtin').live_grep() end, opts = { desc = 'Search text in all files' } },

  -- Clear highlights on search
  { mode = 'n', lhs = '<Esc>', rhs = '<cmd>nohlsearch<CR>', opts = { desc = 'Clear search highlights' } },

  -- Exit terminal mode
  { mode = 't', lhs = '<C-/>', rhs = '<C-\\><C-n>', opts = { desc = 'Exit terminal mode' } },

  -- Window navigation (Ctrl + hjkl)
  { mode = 'n', lhs = '<C-h>', rhs = '<C-w><C-h>', opts = { desc = 'Focus: Window left' } },
  { mode = 'n', lhs = '<C-l>', rhs = '<C-w><C-l>', opts = { desc = 'Focus: Window right' } },
  { mode = 'n', lhs = '<C-j>', rhs = '<C-w><C-j>', opts = { desc = 'Focus: Window down' } },
  { mode = 'n', lhs = '<C-k>', rhs = '<C-w><C-k>', opts = { desc = 'Focus: Window up' } },

  -- Window resizing (Ctrl + Arrow keys)
  { mode = 'n', lhs = '<C-Up>', rhs = '<cmd>resize +2<CR>', opts = { desc = 'Window: Increase height' } },
  { mode = 'n', lhs = '<C-Down>', rhs = '<cmd>resize -2<CR>', opts = { desc = 'Window: Decrease height' } },
  { mode = 'n', lhs = '<C-Left>', rhs = '<cmd>vertical resize -2<CR>', opts = { desc = 'Window: Decrease width' } },
  { mode = 'n', lhs = '<C-Right>', rhs = '<cmd>vertical resize +2<CR>', opts = { desc = 'Window: Increase width' } },

  -- Move lines up and down (Alt + jk)
  { mode = 'n', lhs = '<A-j>', rhs = ':m .+1<CR>==', opts = { desc = 'Move line down', silent = true } },
  { mode = 'n', lhs = '<A-k>', rhs = ':m .-2<CR>==', opts = { desc = 'Move line up', silent = true } },
  { mode = 'v', lhs = '<A-j>', rhs = ":m '>+1<CR>gv=gv", opts = { desc = 'Move selection down', silent = true } },
  { mode = 'v', lhs = '<A-k>', rhs = ":m '<-2<CR>gv=gv", opts = { desc = 'Move selection up', silent = true } },

  -- Quick save and quit
  { mode = 'n', lhs = '<leader>w', rhs = '<cmd>w<CR>', opts = { desc = 'Save file' } },
  { mode = 'n', lhs = '<leader>W', rhs = '<cmd>wa<CR>', opts = { desc = 'Save all files' } },
  { mode = 'n', lhs = '<leader>Q', rhs = '<cmd>qa<CR>', opts = { desc = 'Quit all' } },
}
