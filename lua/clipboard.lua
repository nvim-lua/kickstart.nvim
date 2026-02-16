-- clipboard.lua
-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
if vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil then
  -- If running nvim over an ssh connection, try syncing the clipboard via OSC52.
  if vim.env.ZELLIJ == nil then
    -- If running outside of ZELLIJ, use OSC52 for both copy and paste.
    vim.schedule(function()
      vim.o.clipboard = 'unnamedplus'
      vim.g.clipboard = 'osc52'
    end)
  else
    -- If running over SSH *and* inside of zellij, use OSC52 only for copy.
    vim.schedule(function()
      vim.o.clipboard = 'unnamedplus'
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy '+',
          ['*'] = require('vim.ui.clipboard.osc52').copy '*',
        },
        paste = {
          ['+'] = function()
            return vim.split(vim.fn.getreg '', '\n'), vim.fn.getregtype ''
          end,
          ['*'] = function()
            return vim.split(vim.fn.getreg '', '\n'), vim.fn.getregtype ''
          end,
        },
      }
    end)
  end
else
  -- If running on the host machine, try to sync the system clipboard using the system clipboard provider.
  -- Schedule the setting after `UiEnter` because it can increase startup-time.
  vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
  end)
end
