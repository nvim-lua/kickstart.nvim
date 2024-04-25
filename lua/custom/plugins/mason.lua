return {
  'williamboman/mason.nvim',
  opts = {
    ensure_installed = {
      'yamllint',
      'codespell',
      'stylua', -- Used to format Lua code
      'cpplint',
      'clangd',
      'clang-format',
      'codelldb',
      'cmake-language-server',
      'ruff',
      'pyright',
      'prettier',
      'autopep8',
      'djlint',
      'typescript-language-server',
      'deno',
    },
  },
}
