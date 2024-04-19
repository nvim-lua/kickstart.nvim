return {
  'dense-analysis/ale',
  config = function()
    -- Configuration goes here.
    local g = vim.g
    g.ale_fixers = {
      typescript = { 'prettier_d' },
      html = { 'prettier_d' },
      javascript = { 'prettier_d' },
      typescriptreact = { 'prettier_d' },
    }
    g.ale_linters = {
      lua = { 'lua_language_server' },
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      html = {},
    }
  end,
}
