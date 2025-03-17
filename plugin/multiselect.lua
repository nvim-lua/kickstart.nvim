-- Add this to your init.lua or create a file in your lua director-- Add this to your init.lua or create a file in your lua directory
-- and require it from your init.lua

-- State variables
local selection_active = false
local selected_symbol = nil
local initial_pos = nil
local visual_mode_active = false

-- Function to select the current symbol and handle iteration
function select_and_iterate_symbol()
  -- Exit visual mode first if active to prevent issues
  if visual_mode_active then
    vim.cmd 'normal! <Esc>'
    visual_mode_active = false
  end

  -- If selection is not active, start a new selection
  if not selection_active then
    -- Get the current symbol under cursor (includes special characters)
    local current_symbol = vim.fn.expand '<cword>'

    -- Check if there's actually a symbol under the cursor
    if current_symbol == '' then
      vim.api.nvim_echo({ { 'No symbol under cursor', 'ErrorMsg' } }, false, {})
      return
    end

    -- Store the symbol for later use (exact match)
    selected_symbol = current_symbol

    -- Store the initial position before moving
    initial_pos = vim.fn.getpos '.'

    -- Set up a search pattern for the exact symbol
    vim.fn.setreg('/', '\\V\\<' .. vim.fn.escape(selected_symbol, '\\') .. '\\>')

    -- Enter visual mode and select the current symbol
    vim.cmd 'normal! viw'
    visual_mode_active = true

    -- Set state to active
    selection_active = true

    -- Echo instructions
    vim.api.nvim_echo({ { 'Selected symbol: ' .. current_symbol .. '. Press Ctrl-R again to iterate, <CR> to edit all.', 'Normal' } }, false, {})
  else
    -- Selection is active, find the next occurrence

    -- Search for the next occurrence (exact match with very nomagic mode \V)
    local search_pattern = '\\V\\<' .. vim.fn.escape(selected_symbol, '\\') .. '\\>'
    local found = vim.fn.search(search_pattern, 'W')

    if found == 0 then
      -- If no more occurrences, wrap around to the beginning
      vim.cmd 'normal! gg'
      found = vim.fn.search(search_pattern, 'W')

      -- If still no occurrences or we've come full circle
      if found == 0 or vim.fn.line '.' == vim.fn.line(initial_pos[2]) and vim.fn.col '.' == vim.fn.col(initial_pos[3]) then
        vim.api.nvim_echo({ { 'No more occurrences found.', 'Normal' } }, false, {})
        -- Reset state
        selection_active = false
        selected_symbol = nil
        initial_pos = nil
        return
      end
    end

    -- Select the symbol
    vim.cmd 'normal! viw'
    visual_mode_active = true
  end
end

-- Function to edit all occurrences
function edit_all_occurrences()
  -- If no symbol is selected, do nothing
  if not selection_active then
    vim.api.nvim_echo({ { 'No symbol selected. Use Ctrl-R first.', 'ErrorMsg' } }, false, {})
    return
  end

  -- Exit visual mode
  vim.cmd 'normal! <Esc>'
  visual_mode_active = false

  -- Set up a command to find and replace with very nomagic mode for exact matching
  local escaped_symbol = vim.fn.escape(selected_symbol, '/\\')
  local cmd = ':%s/\\V\\<' .. escaped_symbol .. '\\>//gc'

  -- Use feedkeys with 'n' to avoid triggering mappings
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':' .. cmd, true, false, true), 'n', false)

  -- Reset state
  selection_active = false
  selected_symbol = nil
  initial_pos = nil
end

-- Reset function for cancellation
function reset_selection()
  selection_active = false
  selected_symbol = nil
  initial_pos = nil
  visual_mode_active = false
  vim.cmd 'normal! <Esc>'
  vim.api.nvim_echo({ { 'Symbol selection canceled', 'Normal' } }, false, {})
end

-- Set up key mappings
vim.api.nvim_set_keymap('n', '<C-r>', [[<Cmd>lua select_and_iterate_symbol()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-r>', [[<Cmd>lua select_and_iterate_symbol()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<CR>', [[<Cmd>lua edit_all_occurrences()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Esc>', [[<Cmd>lua reset_selection()<CR>]], { noremap = true, silent = true })
