return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      integrations = {
        telescope = true,
        treesitter = true,
        cmp = true,
        gitsigns = true,
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.mauve },
          CursorLineNr = { fg = colors.lavender, bold = true },
          Visual = { bg = colors.surface1 },
          TelescopeSelection = { bg = colors.surface1 },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
