return {
  'stevearc/conform.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
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
    }

    require('conform').setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'stylua',
        'ruff',
        'isort',
        'black',
        'gofumpt',
        'goimports',
      },
    })
  end,
}

