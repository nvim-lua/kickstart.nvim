vim.lsp.config('pyright', {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { ignore = { '*' } } },
  },
})

return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'clangd', 'gopls', 'pyright', 'ts_ls', 'ruff' },
      automatic_enable = true,
    },
  },
}
