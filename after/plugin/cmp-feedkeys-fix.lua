-- Fix for nvim-cmp feedkeys issue where 'lua require"cmp.utils.feedkeys".run(#)'
-- gets inserted into buffers instead of being executed
-- This overrides the problematic debounce_next_tick_by_keymap function

local ok, async = pcall(require, 'cmp.utils.async')
if not ok then
  return
end

-- Override the problematic function with a safer implementation
async.debounce_next_tick_by_keymap = function(callback)
  return function()
    -- Use vim.schedule instead of feedkeys to avoid inserting command text
    vim.schedule(callback)
  end
end
