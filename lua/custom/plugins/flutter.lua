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
  -- NVIM-DAP - Debug Adapter Protocol for Flutter debugging
  -- ========================================================================
  -- Load DAP when opening Dart files to enable breakpoint debugging
  {
    'mfussenegger/nvim-dap',
    ft = 'dart',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
  },

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
  --
  -- Debug keymaps:
  --   <F5> - Start/Continue debugging
  --   <F10> - Step over
  --   <F11> - Step into
  --   <F12> - Step out
  --   <leader>db - Toggle breakpoint
  --   <leader>dB - Set conditional breakpoint
  --   <leader>dc - Continue
  --   <leader>dt - Terminate debugging
  -- ========================================================================
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart', -- Only load when opening Dart files
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- Optional: better UI for Flutter commands
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      -- Get shared LSP capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('flutter-tools').setup {
        -- Flutter SDK path (usually auto-detected, but you can specify if needed)
        -- flutter_path = '/path/to/flutter/bin/flutter',
        
        -- Uncomment to set a default device (get ID from `flutter devices`)
        -- device = {
        --   id = 'chrome', -- or 'macos', 'emulator-5554', etc.
        -- },

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
          notify_errors = false, -- Don't show error notifications for log buffer issues
          open_cmd = 'tabedit', -- Open logs in a new tab
          focus_on_open = false, -- Don't auto-focus the log window
        },

        debugger = {
          enabled = true, -- Enable Flutter debugger integration
          run_via_dap = true, -- Use DAP for debugging
          -- Flutter tools will automatically register DAP configurations
          -- No need to manually configure launch.json
        },
      }

      -- ========================================================================
      -- DAP UI SETUP - Beautiful debugging interface
      -- ========================================================================
      local dap, dapui = require 'dap', require 'dapui'

      -- Configure DAP UI
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
        -- Fix layout to prevent resizing issues with Neo-tree
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            size = 40, -- Fixed width instead of percentage
            position = 'right', -- Changed to right to avoid conflict with Neo-tree on left
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10, -- Fixed height
            position = 'bottom',
          },
        },
      }

      -- Automatically open/close DAP UI
      -- Don't close Neo-tree, they can coexist now (DAP on right, Neo-tree on left)
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Fix for Flutter Tools log buffer becoming non-modifiable
      -- This catches all buffer types that might be used for Flutter logs
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = '*',
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          -- Check if this is a Flutter log buffer
          if bufname:match('__FLUTTER_DEV_LOG__') or vim.bo[args.buf].filetype == 'log' then
            vim.bo[args.buf].modifiable = true
            vim.bo[args.buf].readonly = false
            vim.bo[args.buf].buftype = '' -- Make it a normal buffer
          end
        end,
      })

      -- Also fix it whenever Flutter tries to write to the log
      vim.api.nvim_create_autocmd('BufModifiedSet', {
        pattern = '*',
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname:match('__FLUTTER_DEV_LOG__') then
            vim.bo[args.buf].modifiable = true
          end
        end,
      })

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
          -- WORKFLOW: 
          --   1. First time: <leader>fd to select device
          --   2. Then: <leader>fr to run (uses selected device)
          --   3. Subsequent runs: <leader>fr uses same device
          vim.keymap.set('n', '<leader>fr', '<cmd>FlutterRun<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [R]un' }))
          vim.keymap.set('n', '<leader>fR', '<cmd>FlutterRestart<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter Hot [R]estart' }))
          vim.keymap.set('n', '<leader>fq', '<cmd>FlutterQuit<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [Q]uit' }))

          -- Code Actions (Cmd+. equivalent) - wrap, remove, extract widgets, etc.
          vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Actions (Cmd+.)' }))
          vim.keymap.set('v', '<leader>.', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Actions (Cmd+.)' }))
          -- Alternative: use the default LSP keymap
          vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = '[G]oto Code [A]ction' }))
          vim.keymap.set('v', 'gra', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = '[G]oto Code [A]ction' }))

          -- Device management
          -- Use <leader>fd to see/select devices FIRST, then <leader>fr will use that device
          vim.keymap.set('n', '<leader>fd', '<cmd>FlutterDevices<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [D]evices (select)' }))
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

          -- ========================================================================
          -- DEBUG KEYMAPS - Available only in Dart files
          -- ========================================================================
          -- Function key shortcuts (standard debugging)
          vim.keymap.set('n', '<F5>', function()
            require('dap').continue()
          end, vim.tbl_extend('force', opts, { desc = 'Debug: Start/Continue' }))

          vim.keymap.set('n', '<F10>', function()
            require('dap').step_over()
          end, vim.tbl_extend('force', opts, { desc = 'Debug: Step Over' }))

          vim.keymap.set('n', '<F11>', function()
            require('dap').step_into()
          end, vim.tbl_extend('force', opts, { desc = 'Debug: Step Into' }))

          vim.keymap.set('n', '<F12>', function()
            require('dap').step_out()
          end, vim.tbl_extend('force', opts, { desc = 'Debug: Step Out' }))

          -- Leader-based debug commands
          vim.keymap.set('n', '<leader>db', function()
            require('dap').toggle_breakpoint()
          end, vim.tbl_extend('force', opts, { desc = '[D]ebug: Toggle [B]reakpoint' }))

          vim.keymap.set('n', '<leader>dB', function()
            require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
          end, vim.tbl_extend('force', opts, { desc = '[D]ebug: Set Conditional [B]reakpoint' }))

          vim.keymap.set('n', '<leader>dc', function()
            require('dap').continue()
          end, vim.tbl_extend('force', opts, { desc = '[D]ebug: [C]ontinue' }))

          vim.keymap.set('n', '<leader>dt', function()
            require('dap').terminate()
          end, vim.tbl_extend('force', opts, { desc = '[D]ebug: [T]erminate' }))

          vim.keymap.set('n', '<leader>du', function()
            require('dapui').toggle()
          end, vim.tbl_extend('force', opts, { desc = '[D]ebug: Toggle [U]I' }))

          -- Register groups with which-key
          require('which-key').add {
            { '<leader>f', group = '[F]lutter', mode = 'n' },
            { '<leader>d', group = '[D]ebug', mode = 'n' },
          }
        end,
      })
    end,
  },
}
