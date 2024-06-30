return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<A-f>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'biome' },
        typescript = { 'biome' },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = {
          --[[  c = true, cpp = true  ]]
        }
        return {
          timeout_ms = 3000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
    },
  },
}
