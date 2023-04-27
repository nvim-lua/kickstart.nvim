local dap = require("dap")

local launch = {
    name = 'Debug index.html with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    file = "${workspaceFolder}/index.html",
}

table.insert(dap.configurations.javascript, launch)
table.insert(dap.configurations.typescript, launch)
