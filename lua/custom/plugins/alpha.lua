return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    enabled = false,
    init = false,
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', '<cmd>ene <CR>'),
        dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<cr>'),
        dashboard.button('h', '󰊄  Recently opened files', '<cmd>Telescope oldfiles<cr>'),
        dashboard.button('g', '󰈬  Find word', '<cmd>Telescope live_grep<cr>'),
        dashboard.button('s', '  Open last session', '<cmd> lua require("persistence").load() <cr>'),
        dashboard.button('sl', '  Select Session', '<cmd> lua require("persistence").select() <cr>'),
        dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
        dashboard.button('c', '  Configuration', "<cmd>lua require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } <cr>"),
        dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
      }
      alpha.setup(dashboard.config)
    end,
  },
}
