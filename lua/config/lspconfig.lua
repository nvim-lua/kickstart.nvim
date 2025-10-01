-- LSP configuration for Kotlin and Java with Maven support
-- This file contains LSP server configurations that are loaded on startup
  
return function()
  -- Kotlin LSP configuration (Official Kotlin LSP)
  vim.lsp.config('kotlin_language_server', {
    filetypes = { 'kotlin' },
    root_markers = {
      'pom.xml',
      'build.gradle',
      'build.gradle.kts',
      'settings.gradle',
      'settings.gradle.kts'
    },
    single_file_support = true,
  })
  vim.lsp.enable('kotlin_language_server')

  vim.lsp.set_log_level("debug")

  -- Java LSP configuration
  vim.lsp.config('jdtls', {
    filetypes = { 'java' },
    root_markers = {
      'pom.xml',
      'build.gradle',
      'build.gradle.kts',
      '.git'
    },
    single_file_support = true,
       
  })
  vim.lsp.enable('jdtls')
end