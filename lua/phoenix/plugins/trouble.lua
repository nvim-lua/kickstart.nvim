---@type function
---comment
---@param mode any
---@param keymap any
---@param trouble_fn any
---@param desc any
local map = function(mode, keymap, trouble_fn, desc)
  vim.keymap.set(mode, keymap, function()
    require('trouble').open(trouble_fn)
  end, { desc = "Trouble: " .. desc })
end

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    auto_preview = false,
    icons = false,
    fold_open = 'v',   -- icon used for open folds
    fold_closed = '>', -- icon used for closed folds
    signs = {
      -- icons / text used for a diagnostic
      error = 'error',
      warning = 'warn',
      hint = 'hint',
      information = 'info',
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  },
  config = function()
    map('n', '<leader>xx', nil, "show window")
    map('n', '<leader>xw', 'workspace_diagnostics', "show [w]orkspace diagnostics")
    map('n', '<leader>xd', 'document_diagnostics', "show [d]ocument diagnostics")
    map('n', '<leader>xq', 'quickfix', "show [q]uickfix list")
    map('n', '<leader>xl', 'loclist', "show [l]ocation list")
    map('n', 'gR', 'lsp_references', "")
  end,
}
