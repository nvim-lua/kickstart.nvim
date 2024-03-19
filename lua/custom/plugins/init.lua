-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    opts = {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      persist_mode = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context'
  },
}
