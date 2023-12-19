local uname = vim.loop.os_uname()
local sysname = uname.sysname
local machine = uname.machine

local enableCodeium = true

-- Check if the system is Linux and the machine is aarch64
if sysname == "Linux" and machine == "aarch64" then
  -- Disable cmp-tabnine plugin
  enableCodeium = false
end


return {
    'Exafunction/codeium.vim',
    enabled = enableCodeium
}
