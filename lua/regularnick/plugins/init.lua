-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup { transparent_background = true }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  {
    'Mofiqul/dracula.nvim',
    name = 'dracula',
    config = function()
      require('dracula').setup { transparent_bg = true }
      --   vim.cmd.colorscheme 'dracula'
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'Mofiqul/dracula.nvim' },
    config = function()
      require('bufferline').setup {
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
      }
    end,
  },
}
