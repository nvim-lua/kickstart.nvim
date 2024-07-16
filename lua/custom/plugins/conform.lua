return {
  { -- Autoformat
    'stevearc/conform.nvim',

    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        -- go = { 'goimports', 'gofmt' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        ['*'] = { 'trim_whitespace' },
      },
    },
  },
}
