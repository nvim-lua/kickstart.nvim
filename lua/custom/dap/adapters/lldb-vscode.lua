local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode'
}
