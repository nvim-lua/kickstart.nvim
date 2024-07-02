return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      settings = {
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
            -- 'typescript-styled-plugin',
        },
      },
    }
  end,
}
