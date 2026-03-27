-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'neovim/nvim-lspconfig',
    init_options = {
      userLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        rust = 'html',
        python = 'py',
      },
    },
  },
}
