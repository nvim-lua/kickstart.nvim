return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 999,
  config = function()
    require('tokyonight').setup {
      style = 'storm',
      transparent = true,
    }

    vim.cmd.colorscheme 'tokyonight'
  end,
}
