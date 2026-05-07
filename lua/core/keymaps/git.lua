---@diagnostic disable: undefined-global
-- Git keymaps

local M = {}

M.keymaps = {
  -- Navigation
  { mode = 'n', lhs = ']c', rhs = function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() require('gitsigns').next_hunk() end)
    return '<Ignore>'
  end, opts = { desc = 'Git: Next hunk', expr = true } },

  { mode = 'n', lhs = '[c', rhs = function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() require('gitsigns').prev_hunk() end)
    return '<Ignore>'
  end, opts = { desc = 'Git: Previous hunk', expr = true } },

  -- Actions
  { mode = 'n', lhs = '<leader>gh', rhs = function() require('gitsigns').preview_hunk() end, opts = { desc = 'Git: Preview hunk' } },
  { mode = 'n', lhs = '<leader>gb', rhs = function() require('gitsigns').blame_line() end, opts = { desc = 'Git: Blame line' } },
  { mode = 'n', lhs = '<leader>gd', rhs = function() require('gitsigns').diffthis() end, opts = { desc = 'Git: Show diff' } },
  { mode = { 'n', 'v' }, lhs = '<leader>gs', rhs = function() require('gitsigns').stage_hunk() end, opts = { desc = 'Git: Stage hunk' } },
  { mode = { 'n', 'v' }, lhs = '<leader>gr', rhs = function() require('gitsigns').reset_hunk() end, opts = { desc = 'Git: Reset hunk' } },
  { mode = 'n', lhs = '<leader>gS', rhs = function() require('gitsigns').stage_buffer() end, opts = { desc = 'Git: Stage buffer' } },
  { mode = 'n', lhs = '<leader>gu', rhs = function() require('gitsigns').undo_stage_hunk() end, opts = { desc = 'Git: Undo stage' } },
  { mode = 'n', lhs = '<leader>gR', rhs = function() require('gitsigns').reset_buffer() end, opts = { desc = 'Git: Reset buffer' } },
}

function M.setup()
  for _, mapping in ipairs(M.keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

return M
