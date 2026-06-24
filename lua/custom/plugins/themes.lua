return {
  {
    'folke/tokyonight.nvim',
    opts = {
      styles = {
        comments = { italic = false },
      },
    },
  },
  {
    'motaz-shokry/gruvbox.nvim',
    url = 'https://gitlab.com/motaz-shokry/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup()
      vim.cmd 'colorscheme gruvbox-medium'
    end,
  },
}
