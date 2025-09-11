-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Warn when trying to quit a shared tmux session
local function is_shared_session()
  local tmux = vim.env.TMUX
  if not tmux or tmux == '' then
    return false
  end

  -- Check if session name contains "-nvim-shared"
  local handle = io.popen "tmux display-message -p '#{session_name}' 2>/dev/null"
  if handle then
    local session_name = handle:read('*a'):gsub('\n', '')
    handle:close()
    return session_name:match '%-nvim%-shared$' ~= nil
  end
  return false
end

-- Create an autocommand group for shared session warning
local shared_session_group = vim.api.nvim_create_augroup("SharedSessionWarning", { clear = true })


-- Override quit commands for shared sessions
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = shared_session_group,
  callback = function()
    if is_shared_session() then
      local response = vim.fn.input("⚠️  Closing shared nvim session! Confirm with y/Y: ")
      if response:lower() ~= "y" then
        -- Cancel the quit by throwing an error
        error("Quit cancelled")
      end
    end
  end,
})

