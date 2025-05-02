-- Theme configuration

return {
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  { 'folke/tokyonight.nvim', enabled = false },
}
