local uname = vim.loop.os_uname()
local sysname = uname.sysname
local machine = uname.machine

local enableTabnine = true

-- Check if the system is Linux and the machine is aarch64
if sysname == "Linux" and machine == "aarch64" then
  -- Disable cmp-tabnine plugin
  enableTabnine = false
end

return {
  'codota/tabnine-nvim',
  enabled = enableTabnine,
  build = './dl_binaries.sh',
  config = function()
    require('tabnine').setup {
      disable_auto_comment = true,
      accept_keymap = '<Tab>',
      dismiss_keymap = '<C-]>',
      debounce_ms = 800,
      suggestion_color = { gui = '#808080', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt' },
    }
  end,
}
