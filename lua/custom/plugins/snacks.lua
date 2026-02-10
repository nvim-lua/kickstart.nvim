return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    --TODO: Use this for a bit and compare to mini dashboard
    --TODO: design a style and featuers for my dashboard
    dashboard = { enabled = true },
    lazygit = { enabled = true },
  },
  keys = {
    { '<leader>=', function() Snacks.dashboard.open() end, desc = 'Dashboard' },
    { '<leader>gl', function() Snacks.lazygit.open() end, desc = 'Open Lazy Git' },
  },
}
