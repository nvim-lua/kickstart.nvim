return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.move').setup()
    require('mini.notify').setup()
    require('mini.starter').setup()
    require('mini.statusline').setup {
      use_icons = vim.g.have_nerd_font,
    }
  end,
}
