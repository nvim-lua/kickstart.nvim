return {
  {
    'b0o/schemastore.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      local schemastore = require 'schemastore'
      local lspconfig = require 'lspconfig'
      lspconfig.jsonls.setup {
        settigns = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = {
              enable = true,
            },
          },
        },
      }
      lspconfig.yamlls.setup {
        settigns = {
          yaml = {
            schemas = schemastore.yaml.schemas(),
          },
          schemaStore = {
            enable = true,
          },
        },
      }
    end,
  },
}
