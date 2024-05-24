-- Open file in vscode, for WCA and GPT stuff
vim.api.nvim_create_user_command('OpenInVSCode', function()
  -- Using vim.fn.expand('%') to get the current file path
  local filepath = vim.fn.expand '%:p' -- ':p' expands to full path
  -- The command to open VS Code with the current file
  os.execute('code ' .. filepath)
end, { desc = 'Open the current file in Visual Studio Code' })

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = {
    source = false,
    prefix = '●',
    format = function()
      return ''
    end,
  },
  float = {
    source = 'if_many',
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format('%s [%s]', diagnostic.message, diagnostic.user_data.lsp.code)
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
  },
}

local signs = { Error = '✗', Warn = '⚠', Hint = '➤', Info = 'i' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim: ts=2 sts=2 sw=2 et
