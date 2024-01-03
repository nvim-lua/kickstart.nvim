return {
  'mfussenegger/nvim-dap',
  optional = true,
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = function (_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'js-debug-adapter')
      end,
    },
  },
  opts = function ()
    local dap = require('dap')
    if not dap.adapters['pwa-node'] then
      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            require('mason-registry').get_package('js-debug-adapter'):get_install_path()
              .. '/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }
    end
    for _, language in ipairs({ 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}'
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
        }
      end
    end
  end,
}
