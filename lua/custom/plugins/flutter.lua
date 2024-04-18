return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    local flutterConfig = require("flutter-tools")

    flutterConfig.setup {
      ui = {
        border = "rounded",
        notification_style = 'native'
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = true,
        }
      },
      debugger = {           -- integrate with nvim dap + install dart code debugger
        enabled = true,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {}
      },
      root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
      fvm = true,                                 -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "Comment", -- highlight for the closing tag
        prefix = "//",         -- character to use for close tag e.g. > Widget
        enabled = true         -- set to false to disable
      },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "tabedit",  -- command to us
      },
      dev_tools = {
        autostart = false,         -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },
      outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
        auto_open = false    -- if true this will open the outline automatically when it is first populated
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        --- OR you can specify a function to deactivate or change or control how the config is created
        capabilities = function(config)
          config.specificThingIDontWant = false
          return config
        end,
        analysisExcludedFolders = { "./fvm/" },
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt", -- "always"
          -- enableSnippets = true,
          previewLsp = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        }
      }
    }
    -- [[ Configure Flutter tools]]
    vim.keymap.set('n', '<leader>r', require('telescope').extensions.flutter.commands, { desc = 'Open command Flutter' })
    vim.keymap.set('n', '<leader>br', function()
      vim.cmd('20new')
      vim.cmd('te fvm flutter packages pub run build_runner build --delete-conflicting-outputs')
      vim.cmd('2sleep | normal G')
    end)
    vim.keymap.set('n', '<leader>bt', function()
      vim.cmd('20new')
      vim.cmd('te sh scripts/create_clean_lcov_and_generate_html.sh')
      vim.cmd('2sleep | normal G')
    end)
    -- '<Cmd>20new | te fvm flutter pub get && fvm flutter packages pub run build_runner build --delete-conflicting-outputs<CR> | $')
  end
};
