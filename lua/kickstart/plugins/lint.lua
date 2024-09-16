return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- python = { 'mypy' },
        -- typescript = { 'eslint_d' },
        -- javascriptreact = { 'eslint_d' },
        -- typescriptreact = { 'eslint_d' },
        -- svelte = { 'eslint_d' },
        -- kotlin = { 'ktlint' },
        -- terraform = { 'tflint' },
        -- ruby = { 'standardrb' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>ll', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
    end,
  },
}
