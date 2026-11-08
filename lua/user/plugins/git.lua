return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
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

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git stage/unstage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git preview hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git blame line' })
        map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show blame line' })
        map('n', '<leader>gtd', gitsigns.preview_hunk_inline, { desc = 'git preview hunk inline (deleted lines)' })
      end,
    },
  },

  -- {
  --   'tpope/vim-fugitive',
  --   config = function()
  --     vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = 'git diff against index' })
  --   end,
  -- },

  { 'sindrets/diffview.nvim' },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
      -- 'ibhagwan/fzf-lua', -- optional
      -- 'echasnovski/mini.pick', -- optional
    },
    config = true,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'NeoGit' },
      { '<leader>gdi', '<cmd>DiffviewOpen<cr>', desc = 'git diff' },
      { '<leader>gdd', '<cmd>DiffviewOpen develop<cr>', desc = 'git diff against develop' },
      { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = 'DiffviewClose' },
    },
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>gw', '<cmd>LazyGitFilter<cr>', desc = 'Open project commits' },
      { '<leader>gv', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'Open buffer commits' },
    },
  },
}
