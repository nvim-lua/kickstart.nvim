return {
  'mfussenegger/nvim-lint',
  dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    require('lint').linters_by_ft = {
      python = { 'ruff' },
      go = { 'golangcilint' },
      yaml = { 'yamllint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>l', function()
      require('lint').try_lint()
    end, { desc = 'Lint the current buffer' })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'ruff',
        -- 'mypy',
        'golangci-lint',
        'yamllint',
      },
    })
  end,
}
