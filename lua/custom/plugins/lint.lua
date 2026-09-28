-- Linting: https://github.com/mfussenegger/nvim-lint
--
-- Most languages lint through their language server instead:
--   C# -> roslyn analyzers, JS/TS/Vue/Angular -> eslint LSP, Python -> ruff LSP,
--   JSON/YAML -> schema validation in jsonls/yamlls.
-- nvim-lint covers the tools that have no language server.

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'

lint.linters_by_ft = {
  sql = { 'sqlfluff' },
  yaml = { 'yamllint' },
}

-- Default to T-SQL unless the project has its own .sqlfluff config (which then sets the dialect)
lint.linters.sqlfluff.args = {
  'lint',
  '--format=json',
  function()
    if vim.fs.root(0, { '.sqlfluff' }) then return '--nocolor' end
    return '--dialect=tsql'
  end,
  '-',
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only lint buffers you can modify, to skip LSP hover popups and similar
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
