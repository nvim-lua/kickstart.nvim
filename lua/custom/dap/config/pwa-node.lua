local dap = require("dap")
local dap_utils = require("dap.utils")

local launch = {
    type = "pwa-node",
    request = "launch",
    name = "(pwa-node) Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
}
local attach = {
    type = "pwa-node",
    request = "attach",
    name = "(pwa-node) Attach",
    processId = dap_utils.pick_process,
    cwd = "${workspaceFolder}",
}

table.insert(dap.configurations.javascript, launch)
table.insert(dap.configurations.javascript, attach)
table.insert(dap.configurations.typescript, launch)
table.insert(dap.configurations.typescript, attach)
