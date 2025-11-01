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
