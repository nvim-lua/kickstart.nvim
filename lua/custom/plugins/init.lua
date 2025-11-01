-- ========================================================================
-- COMMON PLUGINS - Loaded for all filetypes/profiles
-- ========================================================================
--
-- This file contains plugins that are always loaded regardless of what
-- file type you're working with. These are your "core" plugins that
-- provide functionality across all your language profiles.
--
-- Examples: file explorers, git tools, common UI elements, copilot, etc.
--
-- See the kickstart.nvim README for more information
-- ========================================================================

return {
  -- ========================================================================
  -- FILE EXPLORER - Neo-tree
  -- ========================================================================
  -- Neo-tree provides a modern file explorer sidebar similar to VS Code.
  -- It's loaded for all profiles so you can browse files regardless of
  -- what language you're working with.
  --
  -- Keybindings:
  --   \ (backslash) - Toggle Neo-tree file explorer
  --   Within Neo-tree:
  --     a - Add file/folder
  --     d - Delete
  --     r - Rename
  --     x - Cut
  --     c - Copy
  --     p - Paste
  --     ? - Show help (see all keybindings)
  --
  -- Note: This references the existing neo-tree configuration from
  -- kickstart/plugins/neo-tree.lua. We're just ensuring it's loaded.
  -- ========================================================================
--   {
--     'nvim-neo-tree/neo-tree.nvim',
--     version = '*',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--       'MunifTanjim/nui.nvim',
--     },
--     cmd = 'Neotree', -- Lazy load on command
--     keys = {
--       { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
--     },
--     opts = {
--       filesystem = {
--         window = {
--           mappings = {
--             ['\\'] = 'close_window',
--           },
--         },
--         follow_current_file = {
--           enabled = true, -- Focus on the current file when opening
--         },
--         hijack_netrw_behavior = 'open_current', -- Use neo-tree instead of netrw
--       },
--     },
--   },

  -- ========================================================================
  -- GITHUB COPILOT - AI pair programming assistant
  -- ========================================================================
  -- GitHub Copilot provides AI-powered code completions and suggestions.
  -- Works across all file types and integrates with your completion engine.
  --
  -- Setup:
  --   1. After installing, run :Copilot setup
  --   2. Follow the authentication flow
  --   3. You'll need an active GitHub Copilot subscription
  --
  -- Usage:
  --   - Copilot suggestions appear automatically as you type
  --   - Press Tab to accept a suggestion
  --   - Press Ctrl+] to see next suggestion
  --   - Press Ctrl+[ to see previous suggestion
  --   - :Copilot panel - Open completion panel with multiple suggestions
  --
  -- Commands:
  --   :Copilot setup   - Authenticate with GitHub
  --   :Copilot status  - Check authentication status
  --   :Copilot enable  - Enable Copilot
  --   :Copilot disable - Disable Copilot
  -- ========================================================================
  {
    'github/copilot.vim',
    lazy = false, -- Load immediately on startup (not lazy-loaded)
    config = function()
      -- Copilot keybindings (optional customization)
      -- By default, Tab accepts suggestions, but this might conflict with completion
      -- Uncomment below to use Ctrl+J to accept instead:
      -- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      --   expr = true,
      --   replace_keycodes = false,
      -- })
      -- vim.g.copilot_no_tab_map = true

      -- Optional: Disable Copilot for certain filetypes
      -- vim.g.copilot_filetypes = {
      --   ['*'] = true,
      --   ['markdown'] = false,
      --   ['text'] = false,
      -- }
    end,
  },

  -- ========================================================================
  -- SMOOTH SCROLLING & ANIMATIONS - mini.animate
  -- ========================================================================
  -- Provides smooth scrolling and cursor animations for a better visual experience.
  --
  -- Features:
  --   - Smooth scrolling (when using Ctrl+D, Ctrl+U, etc.)
  --   - Cursor path animation when jumping
  --   - Window resize animations
  --   - Window open/close animations
  --
  -- All animations are non-blocking and can be customized or disabled independently.
  -- ========================================================================
  {
    'echasnovski/mini.animate',
    event = 'VeryLazy', -- Load after UI is ready
    opts = function()
      -- Don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ 'Up', 'Down' }) do
        local key = '<ScrollWheel' .. scroll .. '>'
        vim.keymap.set({ '', 'i' }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require('mini.animate')
      return {
        -- Cursor path animation - shows path when cursor jumps
        cursor = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        
        -- Smooth scrolling
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },

        -- Window resize animation
        resize = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 50, unit = 'total' }),
        },

        -- Window open/close animation
        open = {
          enable = false, -- Disabled by default as it can be distracting
          timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
        },
        
        close = {
          enable = false, -- Disabled by default
          timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
        },
      }
    end,
  },

  -- ========================================================================
  -- TROUBLE.NVIM - Beautiful diagnostics list (LazyVim-style)
  -- ========================================================================
  -- Provides a nice list view of diagnostics, quickfix, LSP references, etc.
  -- Shows errors inline in a dedicated panel like LazyVim/VS Code.
  -- Auto-opens when diagnostics are present to show errors in editor area.
  --
  -- Keymaps:
  --   <leader>xx - Toggle diagnostics list
  --   <leader>xX - Buffer diagnostics
  --   <leader>cs - Symbols list
  --   <leader>cl - LSP references
  --   <leader>xL - Location list
  --   <leader>xQ - Quickfix list
  --   [q / ]q - Previous/next item in trouble list
  -- ========================================================================
  {
    'folke/trouble.nvim',
    cmd = 'Trouble', -- Lazy load on command
    opts = {
      focus = false, -- Don't focus the window when opened (LazyVim behavior)
      auto_close = true, -- Auto close when no items
      auto_open = false, -- Don't auto open (we'll handle this with autocmd)
      warn_no_results = false,
      open_no_results = false,
      modes = {
        -- Configure the diagnostics mode to show in editor area
        diagnostics = {
          mode = 'diagnostics',
          preview = {
            type = 'split',
            relative = 'win',
            position = 'right',
            size = 0.3,
          },
        },
      },
    },
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },

  -- ========================================================================
  -- NOICE.NVIM - Better UI for messages, cmdline, and notifications
  -- ========================================================================
  -- Provides a modern UI for command line, messages, and notifications (LazyVim-style).
  -- Makes the editor feel more polished with popup notifications and floating cmdline.
  --
  -- Features:
  --   - Floating command line
  --   - Modern notification system
  --   - Better message display
  --   - Signature help while typing
  --
  -- Note: This can be disabled if you prefer the classic Vim UI
  -- ========================================================================
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- Optional: If you want to use `nvim-notify` for notifications
      -- 'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      -- Presets for easier configuration
      presets = {
        bottom_search = true, -- Use a classic bottom cmdline for search
        command_palette = true, -- Position the cmdline and popupmenu together
        long_message_to_split = true, -- Long messages will be sent to a split
        inc_rename = false, -- Enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- Add a border to hover docs and signature help
      },
      -- Routes configuration (optional customization)
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
      },
    },
    keys = {
      {
        '<leader>sn',
        '',
        desc = '+noice',
      },
      {
        '<leader>snl',
        function()
          require('noice').cmd('last')
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>snh',
        function()
          require('noice').cmd('history')
        end,
        desc = 'Noice History',
      },
      {
        '<leader>sna',
        function()
          require('noice').cmd('all')
        end,
        desc = 'Noice All',
      },
      {
        '<leader>snd',
        function()
          require('noice').cmd('dismiss')
        end,
        desc = 'Dismiss All',
      },
      {
        '<c-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<c-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<c-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<c-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Backward',
        mode = { 'i', 'n', 's' },
      },
    },
  },

  -- ========================================================================
  -- ADDITIONAL COMMON PLUGINS
  -- ========================================================================
  -- You can add more common plugins here that should be available across
  -- all language profiles. Examples:
  --
  -- - Better terminal integration
  -- - Git integration enhancements (beyond gitsigns in init.lua)
  -- - Session management
  -- - Project management
  -- - Alternative completion sources
  -- - UI enhancements
  --
  -- Just add them to this return table following the same pattern as above.
  -- ========================================================================
}
