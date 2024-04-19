return {
  'dense-analysis/ale',
  config = function()
    -- Configuration goes here.
    local g = vim.g
    g.ale_fixers = {
      typescript = { 'prettierd' },
      html = { 'prettierd' },
      javascript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
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
