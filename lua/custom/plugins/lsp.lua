-- Pyright settings merge via vim.lsp.config deep-merge; mason-lspconfig's
-- automatic_enable fires vim.lsp.enable() for each ensure_installed server.
vim.lsp.config('pyright', {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
})

return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
    ensure_installed = { 'clangd', 'gopls', 'pyright', 'ts_ls', 'ruff' },
    automatic_enable = true,
  },
}
