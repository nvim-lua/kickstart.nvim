return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'first' }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'first',
        }
      end
    end,
    formatters = {
      ['zig-fmt'] = {
        command = 'zig',
        args = { 'fmt', '--stdin' },
        stdin = true,
      },
      biome = {
        --require_cwd = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      typescriptreact = { 'biome-check' },
      javascriptreact = { 'biome-check' },
      typescript = { 'biome-check' },
      javascript = { 'biome-check' },
      json = { 'biome-check' },
      go = { 'gofmt' },
      sql = { 'sqlfmt' },
      zig = { 'zig-fmt' },
      fish = { 'fish_indent' },
    },
  },
}
