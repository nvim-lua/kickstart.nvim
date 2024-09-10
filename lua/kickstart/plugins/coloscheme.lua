return { -- Modified gruvbox
  'ellisonleao/gruvbox.nvim',

  priority = 1000,
  init = function()
    require('gruvbox').setup {
      contrast = 'hard',
      bold = false,
      palette_overrides = {
        -- 6th shade from default
        dark0_hard = '#0e1010',

        -- 4th shade from the default (See color-hex.com)
        bright_purple = '#935d6c',
        dark1 = '#2a2725',
        bright_red = '#af3324',
        bright_yellow = '#af8420',
        bright_orange = '#b15911',
        bright_green = '#80821a',
        bright_aqua = '#638656',
        light1 = '#a4997c',
      },
    }

    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
