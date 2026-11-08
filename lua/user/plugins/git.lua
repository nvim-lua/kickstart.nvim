-- [[ Git ]]

-- gitsigns: signs in the gutter, hunk actions and blame (git-tracked files only)
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation (falls back to ]c / [c in diff mode)
    map('n', ']g', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git change' })

    map('n', '[g', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git change' })

    -- Visual mode
    map('v', '<leader>gs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })

    -- Normal mode
    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git stage/unstage hunk' })
    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git Stage buffer' })
    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git Reset buffer' })
    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git preview hunk' })
    map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git blame line' })
    map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show blame line' })
    map('n', '<leader>gtd', gitsigns.preview_hunk_inline, { desc = 'git preview hunk inline (deleted lines)' })
  end,
}

-- diffview: side-by-side diffs and file history
vim.keymap.set('n', '<leader>gdi', '<cmd>DiffviewOpen<cr>', { desc = 'git diff' })
vim.keymap.set('n', '<leader>gdd', '<cmd>DiffviewOpen develop<cr>', { desc = 'git diff against develop' })
vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<cr>', { desc = 'DiffviewClose' })

-- lazygit in a floating window
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>gw', '<cmd>LazyGitFilter<cr>', { desc = 'Open project commits' })
vim.keymap.set('n', '<leader>gv', '<cmd>LazyGitFilterCurrentFile<cr>', { desc = 'Open buffer commits' })
