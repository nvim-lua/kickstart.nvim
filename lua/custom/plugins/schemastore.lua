return {
  {
    'b0o/schemastore.nvim',
    depenencies = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('lspconfig').jsonls.setup {
        settigns = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = {
              enable = true,
            },
          },
        },
      }
      require('lspconfig').yamlls.setup {
        settigns = {
          yaml = {
            schemas = require('schemastore').yaml.schemas(),
          },
          schemaStore = {
            enable = true,
          },
        },
      }
    end,
  },
}
