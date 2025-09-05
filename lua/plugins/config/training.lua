local M = {}

-- Statistics tracking
local stats = {
  inefficient_moves = 0,
  efficient_moves = 0,
  start_time = os.time(),
}

-- Training mode state
local training_enabled = false

-- Movement key counters for spam detection
local key_counts = { h = 0, j = 0, k = 0, l = 0 }

-- Hard mode: Disable inefficient keys
local function setup_hard_mode()
  -- Disable arrow keys completely
  vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<Nop>', { desc = 'Use k instead!' })
  vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<Nop>', { desc = 'Use j instead!' })
  vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<Nop>', { desc = 'Use h instead!' })
  vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<Nop>', { desc = 'Use l instead!' })

  -- Make holding j/k/h/l painful (warns after 5 repeats)
  for _, key in ipairs { 'h', 'j', 'k', 'l' } do
    vim.keymap.set('n', key, function()
      key_counts[key] = key_counts[key] + 1
      if key_counts[key] > 5 then
        vim.notify(string.format('Stop spamming %s! Use counts (5%s) or better navigation!', key, key), vim.log.levels.WARN)
        key_counts[key] = 0
      end
      return key
    end, { expr = true })
  end

  -- Reset counter when using other movements
  for _, good_move in ipairs { '<C-d>', '<C-u>', '}', '{', 'gg', 'G' } do
    vim.keymap.set('n', good_move, function()
      key_counts = { h = 0, j = 0, k = 0, l = 0 }
      stats.efficient_moves = stats.efficient_moves + 1
      return good_move
    end, { expr = true })
  end
end

-- Smart search helpers
local function setup_smart_search()
  -- Search word under cursor
  vim.keymap.set('n', '<leader>*', '*N', { desc = 'Search word under cursor' })

  -- Search selected text
  vim.keymap.set('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { desc = 'Search selection' })

  -- Replace word under cursor (the smart way)
  vim.keymap.set('n', '<leader>R', function()
    local word = vim.fn.expand '<cword>'
    vim.ui.input({ prompt = 'Replace "' .. word .. '" with: ' }, function(replacement)
      if replacement then
        vim.cmd(':%s/\\<' .. word .. '\\>/' .. replacement .. '/g')
        vim.notify(string.format('Replaced all instances of "%s" with "%s"', word, replacement))
      end
    end)
  end, { desc = 'Replace word under cursor globally' })

  -- cgn workflow helper
  vim.keymap.set('n', '<leader>C', '*Ncgn', { desc = 'Change word under cursor (cgn workflow)' })
end

-- Efficiency helpers
local function setup_efficiency_helpers()
  -- Movement reminder
  vim.keymap.set('n', '<leader>tm', function()
    local hints = {
      '=== VERTICAL MOVEMENT ===',
      'gg/G - Top/bottom of file',
      '50G or 50% - Go to line 50',
      '{ } - Paragraph jumps',
      '[[ ]] - Function/section jumps',
      'H M L - High/Middle/Low of screen',
      '',
      '=== HORIZONTAL MOVEMENT ===',
      'f<char> / F<char> - Find forward/backward',
      't<char> / T<char> - Till forward/backward',
      '; , - Repeat f/t forward/backward',
      '0 $ - Start/end of line',
      '^ g_ - First/last non-blank',
      '',
      '=== WORD MOVEMENT ===',
      'w/W - Next word/WORD',
      'b/B - Back word/WORD',
      'e/E - End of word/WORD',
      'ge/gE - End of previous word/WORD',
      '',
      '=== SEARCH MOVEMENT ===',
      '* # - Search word forward/backward',
      'g* g# - Search partial word',
      'n N - Next/previous match',
    }
    vim.notify(table.concat(hints, '\n'), vim.log.levels.INFO)
  end, { desc = '[T]raining [M]ovement hints' })

  -- Text object practice
  vim.keymap.set('n', '<leader>ti', function()
    local hints = {
      '=== TEXT OBJECTS ===',
      'ciw - Change inside word',
      'ci" - Change inside quotes',
      'ci( or cib - Change inside parentheses',
      'ci{ or ciB - Change inside braces',
      'cit - Change inside tags',
      'cip - Change inside paragraph',
      '',
      '=== VARIATIONS ===',
      'c - Change',
      'd - Delete',
      'y - Yank',
      'v - Visual select',
      '',
      'i - Inside (excludes delimiters)',
      'a - Around (includes delimiters)',
    }
    vim.notify(table.concat(hints, '\n'), vim.log.levels.INFO)
  end, { desc = '[T]ext object [I]nfo' })
end

-- Track statistics
local function setup_statistics()
  -- Track efficient movements
  local efficient_patterns = { '*', '#', 'cgn', 'ciw', 'ci"', "ci'", 'cib', 'ciB', 'f', 'F', 't', 'T', '}', '{', ']]', '[[' }
  
  for _, pattern in ipairs(efficient_patterns) do
    vim.keymap.set('n', pattern, function()
      stats.efficient_moves = stats.efficient_moves + 1
      return pattern
    end, { expr = true, silent = true })
  end
end

-- Visual feedback for good movements
local function setup_visual_feedback()
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = vim.api.nvim_create_augroup('TrainingMode', { clear = true }),
    callback = function()
      if not training_enabled then
        return
      end
      
      local col = vim.fn.col '.'
      local line = vim.fn.line '.'
      
      -- Check if cursor moved significantly (likely used good navigation)
      if math.abs(line - (vim.b.last_line or line)) > 5 then
        -- Don't notify, just track it
        stats.efficient_moves = stats.efficient_moves + 1
      end
      
      vim.b.last_line = line
    end,
  })
end

-- Disable hard mode
local function disable_hard_mode()
  -- Remove hard mode restrictions
  pcall(vim.keymap.del, { 'n', 'v', 'i' }, '<Up>')
  pcall(vim.keymap.del, { 'n', 'v', 'i' }, '<Down>')
  pcall(vim.keymap.del, { 'n', 'v', 'i' }, '<Left>')
  pcall(vim.keymap.del, { 'n', 'v', 'i' }, '<Right>')
  
  -- Remove hjkl spam detection
  for _, key in ipairs { 'h', 'j', 'k', 'l' } do
    pcall(vim.keymap.del, 'n', key)
  end
end

-- Main setup function
function M.setup()
  -- Always setup smart search helpers (they're just helpful)
  setup_smart_search()
  setup_efficiency_helpers()
  setup_visual_feedback()
  
  vim.notify('Training mode available! Press <leader>tt to toggle', vim.log.levels.INFO)
end

-- Toggle training mode
function M.toggle()
  training_enabled = not training_enabled
  
  if training_enabled then
    setup_hard_mode()
    setup_statistics()
    stats.start_time = os.time() -- Reset timer
    vim.notify('Training mode ENABLED! 💪\nArrows disabled, hjkl spam detection on!', vim.log.levels.INFO)
  else
    disable_hard_mode()
    vim.notify('Training mode DISABLED. Keep practicing those efficient movements!', vim.log.levels.INFO)
  end
end

-- Show statistics
function M.show_stats()
  local time_elapsed = os.time() - stats.start_time
  local total_moves = stats.efficient_moves + stats.inefficient_moves
  local efficiency = total_moves > 0 and (stats.efficient_moves / total_moves * 100) or 0
  
  vim.notify(
    string.format(
      '📊 Session Statistics:\n' ..
        'Time: %d min\n' ..
        'Efficient moves: %d\n' ..
        'Inefficient moves: %d\n' ..
        'Efficiency: %.1f%%\n\n' ..
        'Keep practicing! 🎯',
      time_elapsed / 60,
      stats.efficient_moves,
      stats.inefficient_moves,
      efficiency
    ),
    vim.log.levels.INFO
  )
end

-- Random challenge
function M.challenge()
  local challenges = {
    'Jump to line 50 without counting lines (use 50G)',
    'Find the next "function" (use /function)',
    'Change the word in quotes (use ci")',
    'Delete until the next comma (use dt,)',
    'Jump to matching bracket (use %)',
    'Select entire paragraph (use vap)',
    'Change word and repeat with . (use *cgn)',
    'Jump to next blank line (use })',
    'Delete entire function (use dap or di{)',
    'Find and change next "TODO" (use /TODO<CR>cgn)',
  }
  
  local challenge = challenges[math.random(#challenges)]
  vim.notify('🎮 Challenge: ' .. challenge, vim.log.levels.INFO)
end

-- Show cheatsheet
function M.cheatsheet()
  local cheatsheet = [[
=== STOP DOING ===       |  === START DOING ===
jjjjjjjj                  |  10j, }, <C-d>
wwwww                     |  3w, f<char>
manually typing search    |  *, viw/, <leader>sg
:%s/old/new/g            |  *cgn then .
:q then git              |  :Git (Fugitive)
arrow keys               |  hjkl with counts

=== POWER MOVES ===
cgn    - Change next occurrence (use with *)
.      - Repeat last change
*      - Search word under cursor
ciw    - Change inside word
f/t    - Find/till character
%      - Jump to matching bracket
<C-d>  - Half page down
<C-u>  - Half page up

=== TRAINING COMMANDS ===
<leader>tt - Toggle training mode
<leader>ts - Show statistics
<leader>tg - Get random challenge
<leader>tm - Movement hints
<leader>ti - Text object info
<leader>*  - Search word under cursor
<leader>R  - Replace word globally
<leader>C  - Start cgn workflow
]]
  
  vim.notify(cheatsheet, vim.log.levels.INFO)
end

return M