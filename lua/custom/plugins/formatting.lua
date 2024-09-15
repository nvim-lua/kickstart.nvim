return {
  'stevearc/conform.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = function()
    local formatters_by_ft = {
      lua = { 'stylua' },
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'isort', 'ruff_format', 'ruff_fix' }
        else
          return { 'isort', 'black' }
        end
      end,
      go = { 'gofumpt', 'goimports' },
      yaml = { 'prettier' },
      bash = { 'shfmt' },
      rust = { 'rustfmt' },
      dockerfile = { 'hadolint' },
    }

    return {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = formatters_by_ft,
    }
  end,
  config = function(_, opts)
    require('conform').setup(opts)

    require('mason-tool-installer').setup({
      ensure_installed = {
        'stylua',
        'ruff',
        'isort',
        'black',
        'gofumpt',
        'goimports',
        'shfmt',
        'hadolint',
      },
    })
  end,
}
