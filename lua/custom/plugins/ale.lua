return {
  'dense-analysis/ale',
  config = function()
    -- Configuration goes here.
    local g = vim.g
    g.ale_javascript_prettier_use_local_config = 1
    g.ale_fixers = {
      typescript = { 'prettierd' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      javascript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      go = { 'gofmt' },
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
