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
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = {
              enable = true,
            },
          },
        },
      }
      lspconfig.yamlls.setup {
        settings = {
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
