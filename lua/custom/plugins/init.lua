-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
    event = 'VimEnter',
    config = function()
      vim.cmd 'Copilot setup'
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('typescript-tools').setup {
        settings = {
          tsserver_plugins = {
            '@styled/typescript-styled-plugin',
          },
        },
      }
    end,
  },
}
