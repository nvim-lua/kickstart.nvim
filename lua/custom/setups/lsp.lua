require('lspconfig').pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'off', -- disables type checking
        diagnosticMode = 'openFilesOnly', -- optional: only analyze open files
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
