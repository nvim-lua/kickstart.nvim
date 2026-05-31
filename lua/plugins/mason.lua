return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      -- mason-lspconfig only for name-mapping / install bridging, NOT for server setup
      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          -- LSP servers (mason package names)
          'lua-language-server',
          'basedpyright',
          'clangd',
          'typescript-language-server',
          'css-lsp',
          'html-lsp',
          -- Formatters / linters
          'stylua',
          'prettier',
          'ruff',
          'clang-format',
          'markdownlint',
        },
      }
    end,
  },
}
