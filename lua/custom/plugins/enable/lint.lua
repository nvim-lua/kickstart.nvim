return {
  {
    'mfussenegger/nvim-lint',
    ft = { 'markdown' },
    opts = {
      linters = {
        markdownlint = {
          args = { '--disable', 'MD013', '--' },
        },
        ['markdownlint-cli2'] = {
          prepend_args = { '--disable', 'MD013', '--' },
        },
      },
    },
    config = function(_, opts)
      local lint = require 'lint'

      for linter_name, linter_config in pairs(opts.linters or {}) do
        lint.linters[linter_name] = vim.tbl_deep_extend('force', lint.linters[linter_name] or {}, linter_config)
      end
    end,
  },
}
