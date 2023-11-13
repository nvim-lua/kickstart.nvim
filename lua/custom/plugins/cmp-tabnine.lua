local uname = vim.loop.os_uname()
local sysname = uname.sysname
local machine = uname.machine

local enableCmpTabnine = true

-- Check if the system is Linux and the machine is aarch64
if sysname == "Linux" and machine == "aarch64" then
  -- Disable cmp-tabnine plugin
  enableCmpTabnine = false
end

return {
  'tzachar/cmp-tabnine',
  enabled = enableCmpTabnine,
  build = './install.sh',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'tabnine',
      option = {},
    })
    cmp.setup(config)
  end,
}
