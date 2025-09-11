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

-- Override quit commands for shared sessions
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = augroup 'shared_session_warning',
  callback = function()
    if is_shared_session() then
      vim.ui.input({
        prompt = '⚠️ Are you sure you want to close a shared session? ',
      }, function(input)
        if not input or input:lower() ~= 'y' then
          -- Cancel the quit
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', false)
          error 'Quit cancelled'
        end
      end)
    end
  end,
})

