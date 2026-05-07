---@diagnostic disable: undefined-global
-- Diagnostic keymaps

return {
  -- Navigation
  { mode = 'n', lhs = '[d', rhs = vim.diagnostic.goto_prev, opts = { desc = 'Diagnostic: Previous' } },
  { mode = 'n', lhs = ']d', rhs = vim.diagnostic.goto_next, opts = { desc = 'Diagnostic: Next' } },

  -- Viewing diagnostics
  { mode = 'n', lhs = '<leader>tt', rhs = vim.diagnostic.open_float, opts = { desc = 'Diagnostic: Show details in float' } },
  { mode = 'n', lhs = '<leader>tl', rhs = vim.diagnostic.setloclist, opts = { desc = 'Diagnostic: Show list' } },
  { mode = 'n', lhs = '<leader>td', rhs = function() require('telescope.builtin').diagnostics() end, opts = { desc = 'Diagnostic: Search all diagnostics' } },
}
