local lspconfig = require 'lspconfig'
local default_capabilities = require('cmp_nvim_lsp').default_capabilities()
default_capabilities.offsetEncoding = { 'utf-16' }
lspconfig.clangd.setup {
  settings = {
    clangd = {
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
  capabilities = default_capabilities,
}

return {}
