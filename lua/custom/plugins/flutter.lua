-- ========================================================================
-- FLUTTER/DART PROFILE - Language-specific plugins and LSP configuration
-- ========================================================================
--
-- This file contains all Flutter and Dart-specific plugins and configurations.
-- These plugins will ONLY load when you open a .dart file, keeping your
-- startup time fast and avoiding conflicts with other languages.
--
-- Key features to configure here:
--   - Flutter tools (hot reload, device management, widget inspector)
--   - Dart LSP (dartls via flutter-tools)
--   - Dart-specific formatters and linters
--   - Flutter-specific keymaps (e.g., <leader>fr for Flutter Run)
--
-- Usage: Just open a .dart file and these plugins will automatically load!
-- ========================================================================

return {
  -- ========================================================================
  -- FLUTTER TOOLS - Complete Flutter development environment
  -- ========================================================================
  -- Provides Flutter-specific features like hot reload, device management,
  -- widget inspector, and integrates the Dart LSP server.
  --
  -- Flutter-specific keymaps (available in .dart files):
  --   <leader>fr - Flutter Run (start app)
  --   <leader>fq - Flutter Quit (stop app)
  --   <leader>fR - Flutter Hot Restart
  --   <leader>fd - Flutter Devices (show connected devices)
  --   <leader>fe - Flutter Emulators (launch emulator)
  --   <leader>fo - Flutter Outline (toggle outline/widget tree)
  --   <leader>fc - Flutter Copy Profile URL (for DevTools)
  -- ========================================================================
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart', -- Only load when opening Dart files
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- Optional: better UI for Flutter commands
    },
    config = function()
      -- Get shared LSP capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('flutter-tools').setup {
        -- Flutter SDK path (usually auto-detected, but you can specify if needed)
        -- flutter_path = '/path/to/flutter/bin/flutter',

        lsp = {
          capabilities = capabilities,
          -- Settings passed to the Dart LSP
          settings = {
            -- Show TODOs in the problems pane
            showTodos = true,
            -- Completion settings
            completeFunctionCalls = true,
            -- Enable/disable specific lints
            -- analysisExcludedFolders = {},
            renameFilesWithClasses = 'prompt',
            enableSnippets = true,
          },
        },

        -- Flutter-specific settings
        decorations = {
          statusline = {
            -- Set to true to show Flutter app info in statusline
            app_version = false,
            device = true, -- Show device name
          },
        },

        widget_guides = {
          enabled = true, -- Show visual guides for widget nesting
        },

        closing_tags = {
          highlight = 'Comment', -- Highlight color for closing tags
          prefix = '// ', -- Text to show before closing tag
          enabled = true, -- Show closing tags for widgets
        },

        dev_log = {
          enabled = true,
          open_cmd = 'tabedit', -- Open logs in a new tab
        },

        debugger = {
          enabled = true, -- Enable Flutter debugger integration
          run_via_dap = false, -- Use Flutter tools debugger (not DAP)
        },
      }

      -- ========================================================================
      -- FLUTTER-SPECIFIC KEYMAPS
      -- ========================================================================
      -- These keymaps are only available when editing Dart files
      -- They provide quick access to common Flutter commands
      -- ========================================================================
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dart',
        callback = function()
          local opts = { buffer = true, silent = true }

          -- Flutter run/quit
          vim.keymap.set('n', '<leader>fr', '<cmd>FlutterRun<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [R]un' }))
          vim.keymap.set('n', '<leader>fq', '<cmd>FlutterQuit<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [Q]uit' }))
          vim.keymap.set('n', '<leader>fR', '<cmd>FlutterRestart<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter Hot [R]estart' }))

          -- Device management
          vim.keymap.set('n', '<leader>fd', '<cmd>FlutterDevices<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [D]evices' }))
          vim.keymap.set('n', '<leader>fe', '<cmd>FlutterEmulators<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [E]mulators' }))

          -- Dev tools
          vim.keymap.set('n', '<leader>fo', '<cmd>FlutterOutlineToggle<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [O]utline Toggle' }))
          vim.keymap.set(
            'n',
            '<leader>fc',
            '<cmd>FlutterCopyProfilerUrl<cr>',
            vim.tbl_extend('force', opts, { desc = '[F]lutter [C]opy Profiler URL' })
          )
          vim.keymap.set('n', '<leader>fl', '<cmd>FlutterLspRestart<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [L]SP Restart' }))

          -- Register Flutter group with which-key
          require('which-key').add {
            { '<leader>f', group = '[F]lutter', mode = 'n' },
          }
        end,
      })
    end,
  },
}
