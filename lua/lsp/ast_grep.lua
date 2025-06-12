return {
  cmd = { 'ast-grep', 'lsp' },
  filetypes = { 'java', 'javascript', 'html' },
  root_dir = function(fname)
    return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
  end,
  settings = {
    ['ast-grep'] = {
      enable = true,
    },
  },
}
