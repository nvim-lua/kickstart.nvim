-- ========================================================================
-- CHEATSHEET - Comprehensive keymap reference
-- ========================================================================
-- Complete cheatsheet including:
-- - Vim default keymaps
-- - Custom leader keymaps
-- - Plugin-specific keymaps (Telescope, Neo-tree, etc.)
-- - LSP keymaps
-- - Language-specific keymaps
-- ========================================================================

return {
  -- Enhanced cheatsheet with custom data
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      {
        '<leader>sc',
        function()
          -- Create a custom cheatsheet picker
          local pickers = require 'telescope.pickers'
          local finders = require 'telescope.finders'
          local conf = require('telescope.config').values
          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          -- Comprehensive keymap data
          local cheatsheet = {
            -- ============================================================
            -- VIM ESSENTIALS
            -- ============================================================
            { category = 'Vim: Motion', key = 'h/j/k/l', desc = 'Left/Down/Up/Right' },
            { category = 'Vim: Motion', key = 'w/b/e', desc = 'Word forward/backward/end' },
            { category = 'Vim: Motion', key = '0/$', desc = 'Start/end of line' },
            { category = 'Vim: Motion', key = 'gg/G', desc = 'First/last line' },
            { category = 'Vim: Motion', key = '{/}', desc = 'Previous/next paragraph' },
            { category = 'Vim: Motion', key = '%', desc = 'Jump to matching bracket' },
            { category = 'Vim: Motion', key = 'f/F{char}', desc = 'Find char forward/backward' },
            { category = 'Vim: Motion', key = 't/T{char}', desc = 'Till char forward/backward' },
            { category = 'Vim: Motion', key = ';/,', desc = 'Repeat f/t forward/backward' },
            { category = 'Vim: Motion', key = '*/#', desc = 'Search word under cursor' },
            { category = 'Vim: Motion', key = 'n/N', desc = 'Next/previous search result' },

            { category = 'Vim: Editing', key = 'i/a', desc = 'Insert before/after cursor' },
            { category = 'Vim: Editing', key = 'I/A', desc = 'Insert at line start/end' },
            { category = 'Vim: Editing', key = 'o/O', desc = 'New line below/above' },
            { category = 'Vim: Editing', key = 'x/X', desc = 'Delete char under/before cursor' },
            { category = 'Vim: Editing', key = 'd{motion}', desc = 'Delete (dw, dd, d$)' },
            { category = 'Vim: Editing', key = 'c{motion}', desc = 'Change (cw, cc, c$)' },
            { category = 'Vim: Editing', key = 'y{motion}', desc = 'Yank/copy (yw, yy, y$)' },
            { category = 'Vim: Editing', key = 'p/P', desc = 'Paste after/before cursor' },
            { category = 'Vim: Editing', key = 'u/Ctrl-r', desc = 'Undo/redo' },
            { category = 'Vim: Editing', key = '.', desc = 'Repeat last change' },
            { category = 'Vim: Editing', key = 'r{char}', desc = 'Replace character' },
            { category = 'Vim: Editing', key = 'J', desc = 'Join lines' },
            { category = 'Vim: Editing', key = '~', desc = 'Toggle case' },
            { category = 'Vim: Editing', key = '>>/<<', desc = 'Indent/unindent line' },

            { category = 'Vim: Visual', key = 'v/V/Ctrl-v', desc = 'Visual/line/block mode' },
            { category = 'Vim: Visual', key = 'o', desc = 'Go to other end of selection' },
            { category = 'Vim: Visual', key = 'gv', desc = 'Reselect last visual' },

            { category = 'Vim: Search', key = '/{pattern}', desc = 'Search forward' },
            { category = 'Vim: Search', key = '?{pattern}', desc = 'Search backward' },
            { category = 'Vim: Search', key = ':s/old/new/g', desc = 'Substitute in line' },
            { category = 'Vim: Search', key = ':%s/old/new/g', desc = 'Substitute in file' },
            { category = 'Vim: Search', key = ':noh', desc = 'Clear search highlight' },

            { category = 'Vim: Windows', key = 'Ctrl-w s', desc = 'Split horizontal' },
            { category = 'Vim: Windows', key = 'Ctrl-w v', desc = 'Split vertical' },
            { category = 'Vim: Windows', key = 'Ctrl-w c', desc = 'Close window' },
            { category = 'Vim: Windows', key = 'Ctrl-w o', desc = 'Close other windows' },
            { category = 'Vim: Windows', key = 'Ctrl-w =', desc = 'Balance windows' },
            { category = 'Vim: Windows', key = 'Ctrl-h/j/k/l', desc = 'Navigate windows' },

            { category = 'Vim: Tabs', key = ':tabnew', desc = 'New tab' },
            { category = 'Vim: Tabs', key = ':tabc', desc = 'Close tab' },
            { category = 'Vim: Tabs', key = 'gt/gT', desc = 'Next/previous tab' },

            { category = 'Vim: Files', key = ':w', desc = 'Save file' },
            { category = 'Vim: Files', key = ':q', desc = 'Quit' },
            { category = 'Vim: Files', key = ':wq or ZZ', desc = 'Save and quit' },
            { category = 'Vim: Files', key = ':q! or ZQ', desc = 'Quit without saving' },

            -- ============================================================
            -- LEADER KEYMAPS (CORE)
            -- ============================================================
            { category = 'Core: Quit', key = '<Space>Q', desc = 'Quit all' },
            { category = 'Core: Quit', key = '<Space>q', desc = 'Quickfix diagnostics' },
            { category = 'Core: Files', key = '\\', desc = 'Toggle Neo-tree' },
            { category = 'Core: Terminal', key = 'Esc Esc', desc = 'Exit terminal mode (in terminal)' },

            -- ============================================================
            -- BUFFER OPERATIONS
            -- ============================================================
            { category = 'Buffer', key = '<Space>bd', desc = 'Delete buffer' },
            { category = 'Buffer', key = '<Space>bD', desc = 'Delete buffer (force)' },
            { category = 'Buffer', key = '<Space>bn', desc = 'Next buffer' },
            { category = 'Buffer', key = '<Space>bp', desc = 'Previous buffer' },
            { category = 'Buffer', key = '<Space>bo', desc = 'Delete other buffers' },
            { category = 'Buffer', key = '<Space><Space>', desc = 'Find buffers (Telescope)' },

            -- ============================================================
            -- WINDOW OPERATIONS
            -- ============================================================
            { category = 'Window', key = '<Space>ww', desc = 'Other window' },
            { category = 'Window', key = '<Space>wd', desc = 'Delete window' },
            { category = 'Window', key = '<Space>ws', desc = 'Split below' },
            { category = 'Window', key = '<Space>wv', desc = 'Split right' },
            { category = 'Window', key = '<Space>wm', desc = 'Maximize' },
            { category = 'Window', key = '<Space>w=', desc = 'Balance windows' },
            { category = 'Window', key = '<Space>wh/j/k/l', desc = 'Navigate windows' },

            -- ============================================================
            -- SEARCH (TELESCOPE)
            -- ============================================================
            { category = 'Search', key = '<Space>sh', desc = 'Help' },
            { category = 'Search', key = '<Space>sk', desc = 'Keymaps' },
            { category = 'Search', key = '<Space>sf', desc = 'Files' },
            { category = 'Search', key = '<Space>ss', desc = 'Select Telescope' },
            { category = 'Search', key = '<Space>sw', desc = 'Current word' },
            { category = 'Search', key = '<Space>sg', desc = 'Grep' },
            { category = 'Search', key = '<Space>sd', desc = 'Diagnostics' },
            { category = 'Search', key = '<Space>sr', desc = 'Resume' },
            { category = 'Search', key = '<Space>s.', desc = 'Recent files' },
            { category = 'Search', key = '<Space>s/', desc = 'In open files' },
            { category = 'Search', key = '<Space>sn', desc = 'Neovim config' },
            { category = 'Search', key = '<Space>sc', desc = 'Cheatsheet (this!)' },
            { category = 'Search', key = '<Space>sK', desc = 'All keymaps (which-key)' },
            { category = 'Search', key = '<Space>/', desc = 'Fuzzy find in buffer' },

            -- ============================================================
            -- SESSION
            -- ============================================================
            { category = 'Session', key = '<Space>Ss', desc = 'Save session' },
            { category = 'Session', key = '<Space>Sr', desc = 'Restore session' },
            { category = 'Session', key = '<Space>Sd', desc = 'Delete session' },

            -- ============================================================
            -- UI OPERATIONS
            -- ============================================================
            { category = 'UI', key = '<Space>ul', desc = 'Open Lazy' },
            { category = 'UI', key = '<Space>um', desc = 'Open Mason' },
            { category = 'UI', key = '<Space>ui', desc = 'Inspect position' },
            { category = 'UI', key = '<Space>uI', desc = 'Inspect tree' },
            { category = 'UI', key = '<Space>un', desc = 'Dismiss notifications' },

            -- ============================================================
            -- TOGGLE
            -- ============================================================
            { category = 'Toggle', key = '<Space>th', desc = 'Inlay hints' },

            -- ============================================================
            -- DIAGNOSTICS
            -- ============================================================
            { category = 'Diagnostics', key = '<Space>xx', desc = 'Toggle diagnostics (Trouble)' },
            { category = 'Diagnostics', key = '<Space>xX', desc = 'Buffer diagnostics (Trouble)' },
            { category = 'Diagnostics', key = '<Space>xs', desc = 'Symbols (Trouble)' },

            -- ============================================================
            -- GIT
            -- ============================================================
            { category = 'Git', key = '<Space>hs', desc = 'Stage hunk' },
            { category = 'Git', key = '<Space>hr', desc = 'Reset hunk' },
            { category = 'Git', key = '<Space>hS', desc = 'Stage buffer' },
            { category = 'Git', key = '<Space>hu', desc = 'Undo stage hunk' },
            { category = 'Git', key = '<Space>hR', desc = 'Reset buffer' },
            { category = 'Git', key = '<Space>hp', desc = 'Preview hunk' },
            { category = 'Git', key = '<Space>hb', desc = 'Blame line' },
            { category = 'Git', key = '<Space>hd', desc = 'Diff this' },
            { category = 'Git', key = '<Space>hD', desc = 'Diff this ~' },

            -- ============================================================
            -- LSP (ALL LANGUAGES)
            -- ============================================================
            { category = 'LSP', key = 'K', desc = 'Hover documentation' },
            { category = 'LSP', key = 'grd', desc = 'Go to definition' },
            { category = 'LSP', key = 'grD', desc = 'Go to declaration' },
            { category = 'LSP', key = 'gri', desc = 'Go to implementation' },
            { category = 'LSP', key = 'grr', desc = 'Go to references' },
            { category = 'LSP', key = 'grt', desc = 'Go to type definition' },
            { category = 'LSP', key = 'grn', desc = 'Rename' },
            { category = 'LSP', key = 'gra', desc = 'Code action' },
            { category = 'LSP', key = 'gO', desc = 'Document symbols' },
            { category = 'LSP', key = 'gW', desc = 'Workspace symbols' },

            -- ============================================================
            -- DEBUG (ALL LANGUAGES)
            -- ============================================================
            { category = 'Debug', key = 'F5 or <Space>dc', desc = 'Start/Continue' },
            { category = 'Debug', key = 'F10 or <Space>dO', desc = 'Step over' },
            { category = 'Debug', key = 'F11 or <Space>di', desc = 'Step into' },
            { category = 'Debug', key = 'F12 or <Space>do', desc = 'Step out' },
            { category = 'Debug', key = '<Space>db', desc = 'Toggle breakpoint' },
            { category = 'Debug', key = '<Space>dB', desc = 'Conditional breakpoint' },
            { category = 'Debug', key = '<Space>dc or F5', desc = 'Continue' },
            { category = 'Debug', key = '<Space>di or F11', desc = 'Step into' },
            { category = 'Debug', key = '<Space>do or F12', desc = 'Step out' },
            { category = 'Debug', key = '<Space>dO or F10', desc = 'Step over' },
            { category = 'Debug', key = '<Space>dt', desc = 'Terminate' },
            { category = 'Debug', key = '<Space>dr', desc = 'Toggle REPL' },
            { category = 'Debug', key = '<Space>dl', desc = 'Run last' },
            { category = 'Debug', key = '<Space>dC', desc = 'Run to cursor' },
            { category = 'Debug', key = '<Space>du', desc = 'Toggle UI' },
            { category = 'Debug', key = '<Space>de', desc = 'Eval expression' },

            -- ============================================================
            -- FLUTTER (DART FILES)
            -- ============================================================
            { category = 'Flutter', key = '<Space>fr', desc = 'Run app' },
            { category = 'Flutter', key = '<Space>fR', desc = 'Hot restart' },
            { category = 'Flutter', key = '<Space>fh', desc = 'Hot reload' },
            { category = 'Flutter', key = '<Space>fq', desc = 'Quit app' },
            { category = 'Flutter', key = '<Space>fd', desc = 'Select device' },
            { category = 'Flutter', key = '<Space>fe', desc = 'Launch emulator' },
            { category = 'Flutter', key = '<Space>fo', desc = 'Toggle outline' },
            { category = 'Flutter', key = '<Space>ft', desc = 'Start DevTools' },
            { category = 'Flutter', key = '<Space>fa', desc = 'Attach to app' },
            { category = 'Flutter', key = '<Space>fD', desc = 'Detach from app' },
            { category = 'Flutter', key = '<Space>fL', desc = 'Toggle logs' },
            { category = 'Flutter', key = '<Space>fc', desc = 'Copy profiler URL' },
            { category = 'Flutter', key = '<Space>fl', desc = 'Restart LSP' },
            { category = 'Flutter', key = '<Space>. or gra', desc = 'Code actions (Cmd+.)' },

            -- ============================================================
            -- RUST (RUST FILES)
            -- ============================================================
            { category = 'Rust', key = '<Space>rh', desc = 'Hover actions' },
            { category = 'Rust', key = '<Space>ra', desc = 'Code actions' },
            { category = 'Rust', key = '<Space>re', desc = 'Explain error' },
            { category = 'Rust', key = '<Space>rC', desc = 'Open Cargo.toml' },
            { category = 'Rust', key = '<Space>rp', desc = 'Parent module' },
            { category = 'Rust', key = '<Space>rj', desc = 'Join lines' },
            { category = 'Rust', key = '<Space>rr', desc = 'Runnables' },
            { category = 'Rust', key = '<Space>rd', desc = 'Debuggables' },
            { category = 'Rust', key = '<Space>rm', desc = 'Expand macro' },

            -- ============================================================
            -- RUST CRATES (CARGO.TOML)
            -- ============================================================
            { category = 'Rust: Crates', key = '<Space>rct', desc = 'Toggle' },
            { category = 'Rust: Crates', key = '<Space>rcr', desc = 'Reload' },
            { category = 'Rust: Crates', key = '<Space>rcv', desc = 'Show versions' },
            { category = 'Rust: Crates', key = '<Space>rcf', desc = 'Show features' },
            { category = 'Rust: Crates', key = '<Space>rcd', desc = 'Show dependencies' },
            { category = 'Rust: Crates', key = '<Space>rcu', desc = 'Update crate' },
            { category = 'Rust: Crates', key = '<Space>rca', desc = 'Update all' },
            { category = 'Rust: Crates', key = '<Space>rcU', desc = 'Upgrade crate' },
            { category = 'Rust: Crates', key = '<Space>rcA', desc = 'Upgrade all' },

            -- ============================================================
            -- PYTHON (PYTHON FILES)
            -- ============================================================
            { category = 'Python', key = '<Space>pr', desc = 'Run file' },
            { category = 'Python', key = '<Space>pR', desc = 'Run with args' },
            { category = 'Python', key = '<Space>pe', desc = 'Select venv' },
            { category = 'Python', key = '<Space>pl', desc = 'Restart LSP' },
            { category = 'Python', key = '<Space>pi', desc = 'Organize imports' },
            { category = 'Python', key = '<Space>pf', desc = 'Format code' },

            -- ============================================================
            -- SVELTE (SVELTE FILES)
            -- ============================================================
            { category = 'Svelte', key = '<Space>vf', desc = 'Format with prettier' },
            { category = 'Svelte', key = '<Space>vl', desc = 'Restart Svelte LSP' },
            { category = 'Svelte', key = '<Space>vt', desc = 'Restart TypeScript LSP' },
            { category = 'Svelte', key = '<Space>vo', desc = 'Open component in split' },

            -- ============================================================
            -- TELESCOPE (INSIDE TELESCOPE)
            -- ============================================================
            { category = 'Telescope', key = 'Ctrl-j/k or j/k', desc = 'Next/previous item' },
            { category = 'Telescope', key = 'Ctrl-d/u', desc = 'Scroll preview down/up' },
            { category = 'Telescope', key = 'Enter', desc = 'Open in current window' },
            { category = 'Telescope', key = 'Ctrl-x', desc = 'Open in horizontal split' },
            { category = 'Telescope', key = 'Ctrl-v', desc = 'Open in vertical split' },
            { category = 'Telescope', key = 'Ctrl-t', desc = 'Open in new tab' },
            { category = 'Telescope', key = 'Ctrl-c/Esc/q', desc = 'Close' },
            { category = 'Telescope', key = 'Tab/Shift-Tab', desc = 'Toggle selection' },
            { category = 'Telescope', key = 'Ctrl-q', desc = 'Send all to quickfix' },
            { category = 'Telescope', key = 'Alt-q', desc = 'Send selected to quickfix' },
            { category = 'Telescope', key = '? (normal)', desc = 'Show help' },
            { category = 'Telescope', key = 'gg/G (normal)', desc = 'First/last item' },

            -- ============================================================
            -- NEO-TREE (INSIDE NEO-TREE)
            -- ============================================================
            { category = 'Neo-tree', key = '\\, q, or Esc', desc = 'Close Neo-tree' },
            { category = 'Neo-tree', key = 'Enter, o, or 2-click', desc = 'Open file' },
            { category = 'Neo-tree', key = 'Ctrl-x or S', desc = 'Open in horizontal split' },
            { category = 'Neo-tree', key = 'Ctrl-v or s', desc = 'Open in vertical split' },
            { category = 'Neo-tree', key = 'Ctrl-t or t', desc = 'Open in new tab' },
            { category = 'Neo-tree', key = 'w', desc = 'Open with window picker' },
            { category = 'Neo-tree', key = 'Ctrl-j or >', desc = 'Next source (files/buffers/git)' },
            { category = 'Neo-tree', key = 'Ctrl-k or <', desc = 'Previous source' },
            { category = 'Neo-tree', key = 'P', desc = 'Toggle preview (float)' },
            { category = 'Neo-tree', key = 'l', desc = 'Focus preview' },
            { category = 'Neo-tree', key = 'R', desc = 'Refresh' },
            { category = 'Neo-tree', key = 'H', desc = 'Toggle hidden files' },
            { category = 'Neo-tree', key = '-', desc = 'Navigate up (parent dir)' },
            { category = 'Neo-tree', key = '.', desc = 'Set root (cd into directory)' },
            { category = 'Neo-tree', key = 'C', desc = 'Close node (collapse folder)' },
            { category = 'Neo-tree', key = 'z', desc = 'Close all nodes' },
            { category = 'Neo-tree', key = 'e', desc = 'Toggle auto expand width' },
            { category = 'Neo-tree', key = 'a', desc = 'Add file' },
            { category = 'Neo-tree', key = 'A', desc = 'Add directory' },
            { category = 'Neo-tree', key = 'd', desc = 'Delete' },
            { category = 'Neo-tree', key = 'r', desc = 'Rename' },
            { category = 'Neo-tree', key = 'y', desc = 'Copy to clipboard' },
            { category = 'Neo-tree', key = 'x', desc = 'Cut to clipboard' },
            { category = 'Neo-tree', key = 'p', desc = 'Paste from clipboard' },
            { category = 'Neo-tree', key = 'c', desc = 'Copy (with path input)' },
            { category = 'Neo-tree', key = 'm', desc = 'Move (with path input)' },
            { category = 'Neo-tree', key = '?', desc = 'Show help (in Neo-tree)' },
            { category = 'Neo-tree', key = '<Space>sf', desc = 'Telescope find from this dir' },
            { category = 'Neo-tree', key = '<Space>sg', desc = 'Telescope grep from this dir' },

            -- ============================================================
            -- MINI.AI (TEXT OBJECTS)
            -- ============================================================
            { category = 'Text Objects', key = 'a/i + object', desc = 'Around/inside (w, p, [, {, ", \', `, t)' },
            { category = 'Text Objects', key = 'daw', desc = 'Delete around word' },
            { category = 'Text Objects', key = 'ciw', desc = 'Change inside word' },
            { category = 'Text Objects', key = 'di"', desc = 'Delete inside quotes' },
            { category = 'Text Objects', key = 'da(', desc = 'Delete around parentheses' },
            { category = 'Text Objects', key = 'vit', desc = 'Visual inside tag' },

            -- ============================================================
            -- MINI.SURROUND
            -- ============================================================
            { category = 'Surround', key = 'sa{motion}{char}', desc = 'Add surround' },
            { category = 'Surround', key = 'sd{char}', desc = 'Delete surround' },
            { category = 'Surround', key = 'sr{old}{new}', desc = 'Replace surround' },
            { category = 'Surround', key = 'sf{char}', desc = 'Find right surround' },
            { category = 'Surround', key = 'sF{char}', desc = 'Find left surround' },
            { category = 'Surround', key = 'sh', desc = 'Highlight surround' },
          }

          -- Create picker
          pickers
            .new({}, {
              prompt_title = '  Complete Cheatsheet',
              finder = finders.new_table {
                results = cheatsheet,
                entry_maker = function(entry)
                  return {
                    value = entry,
                    display = string.format('%-20s %-25s %s', entry.category, entry.key, entry.desc),
                    ordinal = entry.category .. ' ' .. entry.key .. ' ' .. entry.desc,
                  }
                end,
              },
              sorter = conf.generic_sorter {},
              attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  if selection then
                    vim.notify(
                      string.format('%s: %s\n%s', selection.value.category, selection.value.key, selection.value.desc),
                      vim.log.levels.INFO,
                      { title = 'Keymap' }
                    )
                  end
                end)
                return true
              end,
            })
            :find()
        end,
        desc = 'Cheatsheet (complete reference)',
      },
      {
        '<leader>?',
        function()
          require('telescope.builtin').keymaps()
        end,
        desc = 'Search keymaps',
      },
    },
  },

  -- Which-key can also show a searchable list
  {
    'folke/which-key.nvim',
    keys = {
      {
        '<leader>sK',
        function()
          require('which-key').show { global = true }
        end,
        desc = 'All keymaps (which-key)',
      },
    },
  },
}
