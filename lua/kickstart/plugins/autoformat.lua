-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    -- Force .html files to be recognized as htmldjango for Jinja compatibility
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = '*.html',
      callback = function()
        vim.bo.filetype = 'htmldjango'
      end,
    })

    -- Use :KickstartFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    require('conform').setup {
      formatters_by_ft = {
        python = { 'ruff_organize_imports', 'ruff_format' },
        htmldjango = { 'djlint' },
        html = { 'prettier' },
        css = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
      },
      format_on_save = function(bufnr)
        if not format_is_enabled then
          return nil
        end

        return {
          timeout_ms = 1000,
          lsp_format = 'fallback',
          bufnr = bufnr,
        }
      end,
    }
  end,
}

