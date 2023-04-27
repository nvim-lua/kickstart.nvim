local dap = require("dap")

dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
        vim.fn.stdpath("data") ..
        "/mason/packages/firefox-debug-adapter" ..
        "/dist/adapter.bundle.js" },
}
