-- Place custom vim options here

-- Set based on your font installation
vim.g.have_nerd_font = true

-- Indentation settings
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Add any other custom vim.o or vim.g settings from your old config here
-- For example, if you changed defaults for:
-- vim.opt.number = true -- (Already default in kickstart)
-- vim.opt.mouse = 'a' -- (Already default in kickstart)
-- etc... Review the options section of your old init.lua and add any *changed* values here.
-- The kickstart defaults are generally sensible, so you might not need many overrides.

-- Function to check if running in a shared tmux session
local function is_shared_tmux_session()
  if not vim.env.TMUX then
    return false
  end
  
  local handle = io.popen('tmux list-sessions -F "#{session_name}:#{session_attached}" 2>/dev/null')
  if not handle then
    return false
  end
  
  local current_session = vim.fn.system('tmux display-message -p "#S"'):gsub('\n', '')
  local output = handle:read('*a')
  handle:close()
  
  for line in output:gmatch('[^\r\n]+') do
    local session_name, attached_count = line:match('([^:]+):(%d+)')
    if session_name == current_session and tonumber(attached_count) > 1 then
      return true
    end
  end
  
  return false
end

-- Warn before quitting if in a shared tmux session
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if is_shared_tmux_session() then
      local choice = vim.fn.confirm(
        'You are in a shared tmux session. Other users may be affected.\nDo you really want to quit?',
        '&Yes\n&No',
        2
      )
      if choice ~= 1 then
        return
      end
    end
  end,
})

