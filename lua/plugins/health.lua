--[plugins/health.lua]

return {
    {
        "nvim-lua/plenary.nvim",
        config = function()
        local health = vim.health or require("health")
        health.start("System Checks")

        -- Check Neovim version
        local version = vim.version()
        if version and version.major >= 0 and version.minor >= 9 then
            health.ok("Neovim version is sufficient: " .. version.major .. "." .. version.minor)
            else
                health.error("Neovim 0.9+ required, found " .. version.major .. "." .. version.minor)
                end

                -- Check executables
                local executables = { "git", "make", "unzip", "rg" }
                for _, exe in ipairs(executables) do
                    if vim.fn.executable(exe) == 1 then
                        health.ok(exe .. " is installed")
                        else
                            health.warn(exe .. " not found in PATH")
                            end
                            end
                            end,
    },
}

