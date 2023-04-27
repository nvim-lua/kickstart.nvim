local dap_vscode = require('dap.ext.vscode')

dap_vscode.load_launchjs(nil, {
    cppdbg = { 'c', 'cpp', 'rust' },
    lldb = { 'c', 'cpp', 'rust' },
    codelldb = { 'c', 'cpp', 'rust' },
})

require('custom.dap.config.pwa-node')
require('custom.dap.config.firefox')
