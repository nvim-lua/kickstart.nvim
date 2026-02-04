return {  
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    opts = {
      dev_log = {
        enabled = true,
        open_cmd = '50vnew',
        focus_on_open = false,
      },
      flutter_lookup_cmd = 'mise where flutter',
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
        },
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = '■', -- the virtual text character to highlight
        },
        settings = {
          -- lineLength = 120, -- max line length that the LSP will report when formatting
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt', -- "always"
          enableSnippets = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        },
      },
    },
    root_patterns = { 'mise.toml' },
    config = function(_, opts)
      require('flutter-tools').setup(opts)

      local extensions = require('telescope').extensions
      vim.keymap.set('n', '<leader>fl', extensions.flutter.commands, { desc = '[F]lutter commands' })
      vim.keymap.set(
        'n',
        '<leader>fd',
        '<Cmd>FlutterRun -d macos --flavor dev --dart-define=FLAVOR=dev<CR>',
        { desc = '[F]lutter Run [D]ev Flavor for Desktop' }
      )
      vim.keymap.set('n', '<leader>fr', '<Cmd>FlutterRun --flavor dev --dart-define=FLAVOR=dev<CR>', { desc = '[F]lutter Run [D]ev Flavor' })
      vim.keymap.set(
        'n',
        '<leader>fw',
        '<Cmd>FlutterRun -d chrome --web-experimental-hot-reload --web-browser-flag "--disable-web-security" --web-port 5000<CR>',
        { desc = '[F]lutter Run [W]eb' }
      )
      vim.keymap.set('n', '<leader>fv', extensions.flutter.fvm, { desc = '[F]lutter version manager' })
      vim.keymap.set('n', '<leader>dl', function()
        local buf = vim.fn.bufnr '__FLUTTER_DEV_LOG__'
        if buf == -1 then
          vim.notify('Flutter dev log buffer not found', vim.log.levels.WARN)
          return
        end

        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local file = io.open('/tmp/dart_debug.log', 'w') -- "a" means append
        if not file then
          vim.notify('Failed to open file for writing', vim.log.levels.ERROR)
          return
        end

        for _, line in ipairs(lines) do
          file:write(line .. '\n')
        end
        file:close()
        vim.notify('Appended Flutter dev log to /tmp/dart_debug.log', vim.log.levels.INFO)
      end, { desc = 'Append Flutter dev log to file' })

      vim.keymap.set('n', '<leader>fc', '<Cmd>FlutterLogClear<CR>', { desc = '[F]lutter Log [C]lear' })
      vim.keymap.set('n', '<leader>fo', '<Cmd>FlutterLogToggle<CR>', { desc = '[F]lutter Log T[o]ggle' })
      vim.keymap.set('n', '<leader>fq', '<Cmd>FlutterQuit<CR>', { desc = '[F]lutter [Q]uit' })
      vim.keymap.set('n', '<leader>fs', '<Cmd>FlutterRestart<CR>', { desc = '[F]lutter Re[s]tart' })
    end,
  },
}