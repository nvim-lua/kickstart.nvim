local gh = require('kickstart.util').gh

vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  format_on_save = function(bufnr)
    local enabled_filetypes = {
      go = true,
      hcl = true,
      ps1 = true,
      lua = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    hcl = { 'hclfmt' },
  },
  formatters = {
    hclfmt = {
      command = 'hclfmt',
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
