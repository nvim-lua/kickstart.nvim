--[[
=====================================================================
                    NEOVIM CONFIGURATION
=====================================================================
This configuration started from Kickstart.nvim and has been customized
and reorganized into a modular structure.

For help:
  - Run `:Tutor` to learn Neovim basics
  - Run `:help` to access built-in documentation
  - Press `<Space>sh` to search help with Telescope
  - Run `:checkhealth` to diagnose issues
  - See ORGANIZATION.md for structure details

This is YOUR config now! Customize it to your needs.
=====================================================================
--]]

-- ========================================================================
-- MODULAR NEOVIM CONFIGURATION
-- ========================================================================
-- This configuration has been organized into modular pieces for clarity
-- and maintainability. Each module handles a specific aspect:
--
--   lua/config/
--     ├── options.lua    - Vim settings (leader, mouse, clipboard, etc.)
--     ├── keymaps.lua    - Global keymaps (window navigation, quit, etc.)
--     ├── autocmds.lua   - Global autocommands (highlight yank, etc.)
--     └── lazy.lua       - Plugin manager bootstrap (~50 lines)
--
--   lua/plugins/
--     ├── core/          - Always loaded plugins
--     │   ├── ui.lua            - Colorscheme, statusline, treesitter
--     │   ├── editor.lua        - Telescope, which-key
--     │   ├── git.lua           - Gitsigns
--     │   ├── completion.lua    - Blink.cmp, snippets
--     │   ├── session.lua       - Auto-session
--     │   ├── extras.lua        - Mini.animate, trouble, noice
--     │   └── neo-tree.lua      - File explorer
--     │
--     ├── lsp/           - LSP infrastructure
--     │   └── init.lua          - LSP config, mason, conform
--     │
--     └── lang/          - Language-specific (lazy-loaded by filetype)
--         ├── flutter.lua       - Dart/Flutter (ft='dart')
--         ├── python.lua        - Python (ft='python')
--         └── svelte.lua        - Svelte (ft='svelte')
--
-- See ORGANIZATION.md for detailed information about the structure.
-- See MIGRATION.md for the migration guide from monolithic to modular.
-- ========================================================================

-- Load core configuration modules
require 'config.options'  -- Vim options and settings
require 'config.keymaps'  -- Global keymaps
require 'config.autocmds' -- Global autocommands
require 'config.lazy'     -- Plugin manager and plugins

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
