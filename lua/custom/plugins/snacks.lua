return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    --TODO: Use this for a bit and compare to mini dashboard
    --TODO: design a style and featuers for my dashboard (add opening parent directory with Oil)
    dashboard = { enabled = true },
    gitbrowse = { enabled = true },
    lazygit = { enabled = true },
    --TODO: determine a method for deleting scratches easily
    scratch = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    { '<leader>=', function() Snacks.dashboard.open() end, desc = 'Dashboard' },
    { '<leader>gb', function() Snacks.gitbrowse.open() end, desc = 'Open Git Repository in Browser' },
    { '<leader>gl', function() Snacks.lazygit.open() end, desc = 'Open Lazy Git' },
    { '<leader>no', function() Snacks.scratch() end, desc = 'Open Notepad' },
    { '<leader>ns', function() Snacks.scratch.select() end, desc = 'Select Note' },
    { '<leader><C-t>', function() Snacks.terminal() end, desc = 'Open Terminal' },
  },
}
