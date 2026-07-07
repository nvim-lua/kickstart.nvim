-- Linting: static analysis that catches logic bugs, unused vars, security issues.
-- Different from formatting: linting finds problems; formatting fixes appearance.
-- Runs on BufEnter, BufWritePost, and InsertLeave for modifiable buffers.
local gh = require('kickstart.util').gh

vim.pack.add { gh 'mfussenegger/nvim-lint' }

local lint = require 'lint'

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  sh = { 'shellcheck' },
  bash = { 'shellcheck' },
  zsh = { 'shellcheck' },
  go = { 'golangcilint' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})
