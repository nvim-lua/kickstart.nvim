require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'isort', 'black' },
    -- Use a sub-list to run only the first available formatter
    javascript = { { 'prettierd', 'prettier' } },
    javascriptreact = { { 'prettier' } },
    typescriptreact = { { 'prettier' } },
    typescript = { { 'prettier' } },
    go = { { 'gofumpt', 'goimports-reviser', 'golines' } },
    java = { 'google-java-format' },
  },
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})
