---@module 'lazy'
---@type LazySpec
return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        ' ',
        '   NVIM FORGE   ',
        ' ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '󰱼  Find File', ':Telescope find_files<CR>'),
        dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
        dashboard.button('s', '🧪 Staus', '<cmd>checkhealth<CR>'), -- check system health
        dashboard.button('m', '  Manual', '<cmd>help user-manual<CR>'), -- help specific to Neovim
        dashboard.button('h', '󰖟  Help', '<cmd>help<CR>'), -- general help
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      alpha.setup(dashboard.config)
    end,
  },
}
