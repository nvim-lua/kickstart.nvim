require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' }, --'isort',
    javascript = { { 'prettierd', 'prettier' } },
    javascriptreact = { { 'prettier' } },
    typescriptreact = { { 'prettier' } },
    typescript = { { 'prettier' } },
    xml = { 'prettier', 'xmlformat' },
    html = { { 'prettier' } },
    go = { { 'gofumpt', 'goimports-reviser', 'golines' } },
    java = { 'google-java-format' },
    templ = { 'templ' },
  },
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_fallback = true,
    timeout_ms = 600,
  },
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_fallback = true,
  },
}

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*',
--   callback = function(args)
--     require('conform').format { bufnr = args.buf }
--   end,
-- })
