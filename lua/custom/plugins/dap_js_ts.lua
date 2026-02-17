return {
  'mxsdev/nvim-dap-vscode-js',
  dependencies = { 'mfussenegger/nvim-dap' },
  ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  config = function()
    require('dap-vscode-js').setup {
      debugger_cmd = { 'js-debug-adapter' },
      adapters = {
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
      },
    }

    local dap = require 'dap'
    local configs = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch current file (Node)',
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach to process',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }

    for _, language in ipairs { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' } do
      dap.configurations[language] = vim.list_extend(dap.configurations[language] or {}, configs)
    end
  end,
}
