-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [s]tage [h]unk' })
    map('v', '<leader>ghr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [r]eset hunk' })
    -- normal mode
    map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[g]it [s]tage [h]unk' })
    map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[g]it [r]eset [h]unk' })
    map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = '[g]it [S]tage buffer' })
    map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = '[g]it [R]eset buffer' })
    map('n', '<leader>ghp', gitsigns.preview_hunk_inline, { desc = '[g]it [p]review [h]unk inline' })
    map('n', '<leader>gb', function() gitsigns.blame { full = true } end, { desc = 'git [b]lame' })
    map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>gD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>gQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    map('n', '<leader>gq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })
    -- Toggles
    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>gtw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })

    -- Text object
    map({ 'o', 'x' }, 'gih', gitsigns.select_hunk)
  end,
}
