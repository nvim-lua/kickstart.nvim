return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 5000,
    },
    formatters_by_ft = {
      go = { 'goimports', 'gofmt' },
      terraform = { 'terraform_fmt' },
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      liquid = { 'prettier' },
      -- python = { 'isort', 'black' },
      -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
  -- Configure Neovim tab settings for Go files
  -- vim.api.nvim_create_autocmd('FileType', {
  --   pattern = 'go',
  --   callback = function()
  --     -- vim.bo.expandtab = true -- Use spaces instead of tabs
  --     vim.bo.tabstop = 4 -- Display each tab as 4 spaces
  --     vim.bo.shiftwidth = 4 -- Indentation size of 4 spaces
  --     vim.bo.softtabstop = 4 -- <Tab> key inserts 4 spaces
  --   end,
  -- }),
}
