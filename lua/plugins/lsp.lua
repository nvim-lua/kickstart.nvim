return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'kotlin_language_server', 'jdtls' },
      automatic_installation = true,
      handlers = {
        -- Default handler for all servers
        function(server_name)
          vim.lsp.config(server_name, {})
        end,
        -- Custom handler for specific servers
        kotlin_language_server = function()
          require('config.lspconfig')()
        end,
        jdtls = function()
          require('config.lspconfig')()
        end,
      }
    })
  end,
}

