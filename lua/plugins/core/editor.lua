-- ========================================================================
-- CORE EDITOR PLUGINS
-- ========================================================================
-- Essential editing tools that are always loaded
-- - Telescope: Fuzzy finder
-- - Which-key: Keybinding helper
-- - Neo-tree: File explorer
-- - guess-indent: Auto-detect indentation
-- ========================================================================

return {
  -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',

  -- Telescope: Fuzzy finder (files, LSP, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              -- Navigation (consistent with Neo-tree)
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              
              -- Preview scrolling
              ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
              ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
              
              -- Open actions (consistent with Neo-tree)
              ['<CR>'] = require('telescope.actions').select_default, -- Open in current window
              ['<C-x>'] = require('telescope.actions').select_horizontal, -- Open in horizontal split
              ['<C-v>'] = require('telescope.actions').select_vertical, -- Open in vertical split
              ['<C-t>'] = require('telescope.actions').select_tab, -- Open in new tab
              
              -- Close
              ['<C-c>'] = require('telescope.actions').close,
              ['<Esc>'] = require('telescope.actions').close,
              
              -- Cycle history
              ['<C-n>'] = require('telescope.actions').cycle_history_next,
              ['<C-p>'] = require('telescope.actions').cycle_history_prev,
              
              -- Selection
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
              
              -- Send to quickfix
              ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
              ['<M-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            },
            n = {
              -- Same mappings in normal mode
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
              ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
              
              ['<CR>'] = require('telescope.actions').select_default,
              ['<C-x>'] = require('telescope.actions').select_horizontal,
              ['<C-v>'] = require('telescope.actions').select_vertical,
              ['<C-t>'] = require('telescope.actions').select_tab,
              
              ['q'] = require('telescope.actions').close,
              ['<Esc>'] = require('telescope.actions').close,
              
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
              
              ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
              ['<M-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
              
              -- Vim-like navigation
              ['j'] = require('telescope.actions').move_selection_next,
              ['k'] = require('telescope.actions').move_selection_previous,
              ['gg'] = require('telescope.actions').move_to_top,
              ['G'] = require('telescope.actions').move_to_bottom,
              
              ['?'] = require('telescope.actions').which_key, -- Show help
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- Which-key: Shows pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      -- Floating window configuration (bottom right)
      win = {
        width = { min = 30, max = 60 },  -- Width range for the popup
        height = { min = 4, max = 0.9 }, -- Max 90% of screen height - fits all items
        col = 0.99,                       -- Position close to right edge
        row = 0.95,                       -- Position close to bottom
        border = 'rounded',               -- Border style
        padding = { 1, 2 },               -- Padding inside window
        title = true,                     -- Show title
        title_pos = 'center',             -- Center the title
        wo = {
          winblend = 0,                   -- No transparency (0-100)
        },
      },
      layout = {
        width = { min = 30 },             -- Minimum column width
        spacing = 3,                      -- Spacing between columns
      },
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        -- Core groups with icons
        { '<leader>b', group = '󰊄 buffer', icon = '󰊄' },
        { '<leader>c', group = ' code', icon = '' },
        { '<leader>d', group = ' debug', icon = '' },
        { '<leader>f', group = ' flutter', icon = '' }, -- Only visible in Dart files
        { '<leader>g', group = ' git', icon = '' },
        { '<leader>p', group = ' python', icon = '' }, -- Only visible in Python files
        { '<leader>r', group = '󱘗 rust', icon = '󱘗' }, -- Only visible in Rust files
        { '<leader>s', group = ' search', icon = '' },
        { '<leader>S', group = '󱂬 session', icon = '󱂬' },
        { '<leader>t', group = '󰔡 toggle', icon = '󰔡' },
        { '<leader>u', group = ' ui', icon = '' },
        { '<leader>v', group = ' svelte', icon = '' }, -- Only visible in Svelte files
        { '<leader>w', group = ' window', icon = '' },
        { '<leader>x', group = '󱖫 diagnostics', icon = '󱖫' },
        
        -- Special groups
        { '<leader>q', desc = '󰁨 Quickfix diagnostics' },
        { '<leader>Q', desc = '󰗼 Quit all' },
        
        -- Git hunks (normal and visual mode)
        { '<leader>h', group = ' git hunk', mode = { 'n', 'v' }, icon = '' },
      },
    },
  },

  -- Neo-tree: File explorer
  -- Imported from kickstart/plugins/neo-tree.lua
}
