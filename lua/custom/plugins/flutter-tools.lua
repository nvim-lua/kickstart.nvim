-- Make sure to install fvm in yout system for this to work
return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim', -- optional for vim.ui.select
  },
  opts = {
    fvm = true,
  },
  config = function(_, config_opts)
    local root_patterns = { '.fvm' }
    local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
    if not root_dir then
      return
    end

    require('flutter-tools').setup(config_opts)
    local commands = {
      -- Commands
      'FlutterRun',
      'FlutterDebug',
      'FlutterLspRestart',
      'FlutterAttach',
      'FlutterDetach',
      'FlutterReload',
      'FlutterRestart',
      'FlutterQuit',
      'FlutterVisualDebug',
      'FlutterChangeTargetPlatform',
      'FlutterToggleBrightness',
      -- Lists
      'FlutterDevices',
      'FlutterEmulators',
      --- Outline
      'FlutterOutlineOpen',
      'FlutterOutlineToggle',
      --- Dev tools
      'FlutterDevTools',
      'FlutterDevToolsActivate',
      'FlutterCopyProfilerUrl',
      'FlutterOpenDevTools',
      'FlutterInspectWidget',
      'FlutterPubGet',
      'FlutterPubUpgrade',
      --- Log
      'FlutterLogClear',
      'FlutterLogToggle',
      --- LSP
      'FlutterSuper',
      'FlutterReanalyze',
      'FlutterRename',
    }

    local opts = {}
    opts.prompt = 'Flutter Tools> '
    opts.actions = {
      ['default'] = function(selected)
        vim.cmd(selected)
      end,
    }

    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>F', function()
          require('fzf-lua').fzf_exec(commands, opts)
        end, { desc = 'Flutter Tools Commands' })
      end,
    })
  end,
}
