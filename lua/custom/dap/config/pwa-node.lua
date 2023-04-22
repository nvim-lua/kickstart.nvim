local dap = require("dap")
local dap_utils = require("dap.utils")

local launch = {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
}
local attach = {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = dap_utils.pick_process,
    cwd = "${workspaceFolder}",
}

dap.configurations.javascript = { launch, attach }
dap.configurations.typescript = { launch, attach }
