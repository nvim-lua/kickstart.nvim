-- LSP configuration for Kotlin
-- This file contains LSP server configurations that are loaded on startup

-- Enable Kotlin LSP
vim.lsp.config('kotlin_lsp', {
  filetypes = { 'kotlin' },
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
  },
})

vim.lsp.config('jdtls', {
  filetypes = { 'java' },
  root_markers = {
    'pom.xml',
    'build.gradle',
    'build.gradle.kts',
  },
})

vim.lsp.enable('kotlin_lsp')

vim.diagnostic.enable()