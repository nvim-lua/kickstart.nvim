-- Neovim Training Wheels - Build better vim habits
-- Load nix settings if available
pcall(require, 'nix-settings')

return {
  'dlond/training.nvim',
  enabled = vim.g.training_mode_enabled or false, -- Controlled by Nix
  lazy = false,
  dir = vim.fn.stdpath('config') .. '/lua/plugins/training', -- Local "plugin"
  config = function()
    require('plugins.config.training').setup()
  end,
  keys = {
    { '<leader>tt', function() require('plugins.config.training').toggle() end, desc = '[T]raining [T]oggle' },
    { '<leader>ts', function() require('plugins.config.training').show_stats() end, desc = '[T]raining [S]tats' },
    { '<leader>tg', function() require('plugins.config.training').challenge() end, desc = '[T]raining [G]ame' },
    { '<leader>?', function() require('plugins.config.training').cheatsheet() end, desc = 'Show efficiency cheatsheet' },
  },
}