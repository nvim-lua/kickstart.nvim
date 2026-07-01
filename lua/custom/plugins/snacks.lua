-- return {
--   'folke/snacks.nvim',
--   priority = 1000,
--   lazy = false,
--   ---@type snacks.Config
--   opts = {
--     dashboard = { enabled = true },
--     gitbrowse = { enabled = true },
--     lazygit = { enabled = true },
--     scratch = { enabled = true },
--     terminal = { enabled = true },
--   },
--   keys = {
--     { '<leader>=', function() Snacks.dashboard.open() end, desc = 'Dashboard' },
--     { '<leader>gb', function() Snacks.gitbrowse.open() end, desc = 'Open Git Repository in Browser' },
--     { '<leader>gl', function() Snacks.lazygit.open() end, desc = 'Open Lazy Git' },
--     { '<leader>no', function() Snacks.scratch() end, desc = 'Open Notepad' },
--     { '<leader>ns', function() Snacks.scratch.select() end, desc = 'Select Note' },
--     { '<leader><C-t>', function() Snacks.terminal() end, desc = 'Open Terminal' },
--   },
-- }

--TODO: design a style and features for my dashboard (add opening parent directory with Oil)
--TODO: determine a method for deleting scratches easily

--FIX: postmerge-20260701: Dashboard not working
vim.pack.add { 'https://github.com/folke/snacks.nvim' }
require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
  gitbrowse = { enabled = true },
  lazygit = { enabled = true },
  scratch = { enabled = true },
  terminal = { enabled = true },
}

vim.keymap.set('n', '<leader>=', function() Snacks.dashboard.open() end, { desc = 'Dashboard' })
vim.keymap.set('n', '<leader>gb', function() Snacks.gitbrowse.open() end, { desc = 'Open [G]it Repository in [B]rowser' })
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.open() end, { desc = 'Open [L]azy [G]it' })
vim.keymap.set('n', '<leader>no', function() Snacks.scratch() end, { desc = '[O]pen [N]otepad' })
vim.keymap.set('n', '<leader>ns', function() Snacks.scratch.select() end, { desc = '[S]elect [N]ote' })
vim.keymap.set('n', '<leader><C-t>', function() Snacks.terminal() end, { desc = 'Open [T]erminal' })
