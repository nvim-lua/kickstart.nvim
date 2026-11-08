-- [[ Linting: nvim-lint ]]
-- Language servers already report most problems; this adds linters for
-- filetypes without one. Linters that aren't installed are skipped.

local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('user-lint', { clear = true }),
  callback = function()
    local names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      if type(linter) == 'function' then
        linter = linter()
      end
      local cmd = type(linter) == 'table' and linter.cmd or nil
      if type(cmd) == 'function' then
        cmd = cmd()
      end
      return cmd == nil or vim.fn.executable(cmd) == 1
    end, lint.linters_by_ft[vim.bo.filetype] or {})
    if #names > 0 then
      lint.try_lint(names)
    end
  end,
})
