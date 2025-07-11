local M = {}

-- Debug function to check inline diff state
function M.debug_inline_diff()
  local inline_diff = require('nvim-claude.inline-diff')
  local bufnr = vim.api.nvim_get_current_buf()
  
  vim.notify('=== Inline Diff Debug Info ===', vim.log.levels.INFO)
  
  -- Check if inline diff is active for current buffer
  local diff_data = inline_diff.active_diffs[bufnr]
  if diff_data then
    vim.notify(string.format('✓ Inline diff ACTIVE for buffer %d', bufnr), vim.log.levels.INFO)
    vim.notify(string.format('  - Hunks: %d', #diff_data.hunks), vim.log.levels.INFO)
    vim.notify(string.format('  - Current hunk: %d', diff_data.current_hunk or 0), vim.log.levels.INFO)
    vim.notify(string.format('  - Original content length: %d', #(inline_diff.original_content[bufnr] or '')), vim.log.levels.INFO)
    vim.notify(string.format('  - New content length: %d', #(diff_data.new_content or '')), vim.log.levels.INFO)
  else
    vim.notify(string.format('✗ No inline diff for buffer %d', bufnr), vim.log.levels.WARN)
  end
  
  -- Check all active diffs
  local count = 0
  for buf, _ in pairs(inline_diff.active_diffs) do
    count = count + 1
  end
  vim.notify(string.format('Total active inline diffs: %d', count), vim.log.levels.INFO)
  
  -- Check keymaps
  local keymaps = vim.api.nvim_buf_get_keymap(bufnr, 'n')
  local found_ir = false
  local leader = vim.g.mapleader or '\\'
  local ir_pattern = leader .. 'ir'
  
  vim.notify(string.format('Looking for keymap: %s', ir_pattern), vim.log.levels.INFO)
  
  for _, map in ipairs(keymaps) do
    if map.lhs == ir_pattern or map.lhs == '<leader>ir' then
      found_ir = true
      vim.notify(string.format('✓ Found keymap: %s -> %s', map.lhs, map.desc or 'no desc'), vim.log.levels.INFO)
      break
    end
  end
  
  if not found_ir then
    vim.notify('✗ <leader>ir keymap not found', vim.log.levels.WARN)
    -- List all keymaps that start with leader
    vim.notify('Buffer keymaps starting with leader:', vim.log.levels.INFO)
    for _, map in ipairs(keymaps) do
      if map.lhs:match('^' .. vim.pesc(leader)) or map.lhs:match('^<leader>') then
        vim.notify(string.format('  %s -> %s', map.lhs, map.desc or 'no desc'), vim.log.levels.INFO)
      end
    end
  end
end

return M