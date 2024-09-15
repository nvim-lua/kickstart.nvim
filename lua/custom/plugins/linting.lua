return {
  'mfussenegger/nvim-lint',
  dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    -- Linter configurations based on file type
    require('lint').linters_by_ft = {
      python = { 'ruff' },
      go = { 'golangcilint' },
      yaml = { 'yamllint' },
      bash = { 'shellcheck' },
      lua = { 'luacheck' }, -- Added Lua linter
      rust = { 'clippy' }, -- Use `clippy` for Rust linting
      dockerfile = { 'hadolint' }, -- Added Dockerfile linter
      -- rust = { 'clippy' }, -- Use `clippy` for Rust linting
    }

    -- Autocommand group for triggering linting
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    -- Trigger linting on buffer enter, write, and insert leave
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })

    -- Keybinding to manually lint the current buffer
    vim.keymap.set('n', '<leader>l', function()
      require('lint').try_lint()
    end, { desc = 'Lint the current buffer' })

    -- Mason tool installer setup
    require('mason-tool-installer').setup({
      ensure_installed = {
        -- 'clippy', -- Rust
        'ruff', -- Python
        -- 'mypy',       -- Uncomment if needed for additional Python linting
        'golangci-lint', -- Go
        'yamllint', -- YAML
        'shellcheck', -- Bash
        'luacheck', -- Lua
        'hadolint', -- Dockerfile
      },
    })
  end,
}
