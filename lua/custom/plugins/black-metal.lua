-- Using lazy.nvim
return {
  'metalelf0/black-metal-theme-neovim',
  lazy = false,
  priority = 1000,
  config = function()
    require('black-metal').setup {
      -- optional configuration here
      transparent = false,
    }
    require('black-metal').load()
    vim.cmd 'colorscheme taake'
  end,
}
