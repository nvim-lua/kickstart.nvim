-- Keybinding mappings for nvim-claude
local M = {}

function M.setup(config, commands)
  local prefix = config.prefix or '<leader>c'
  
  -- Basic commands
  vim.keymap.set('n', prefix .. 'c', ':ClaudeChat<CR>', {
    desc = 'Open Claude chat',
    silent = true
  })
  
  vim.keymap.set('n', prefix .. 's', ':ClaudeSendBuffer<CR>', {
    desc = 'Send buffer to Claude',
    silent = true
  })
  
  vim.keymap.set('v', prefix .. 'v', ':ClaudeSendSelection<CR>', {
    desc = 'Send selection to Claude',
    silent = true
  })
  
  vim.keymap.set('n', prefix .. 'h', ':ClaudeSendHunk<CR>', {
    desc = 'Send git hunk to Claude',
    silent = true
  })
  
  vim.keymap.set('n', prefix .. 'b', ':ClaudeBg ', {
    desc = 'Start background agent',
    silent = false  -- Allow user to type the task
  })
  
  vim.keymap.set('n', prefix .. 'l', ':ClaudeAgents<CR>', {
    desc = 'List agents',
    silent = true
  })
  
  vim.keymap.set('n', prefix .. 'k', ':ClaudeKill<CR>', {
    desc = 'Kill agent',
    silent = true
  })
  
  vim.keymap.set('n', prefix .. 'x', ':ClaudeClean<CR>', {
    desc = 'Clean old agents',
    silent = true
  })
  
  -- Register with which-key if available
  local ok, which_key = pcall(require, 'which-key')
  if ok then
    which_key.register({
      [prefix] = {
        name = 'Claude',
        c = { 'Chat' },
        s = { 'Send Buffer' },
        v = { 'Send Selection' },
        h = { 'Send Git Hunk' },
        b = { 'Background Agent' },
        l = { 'List Agents' },
        k = { 'Kill Agent' },
        x = { 'Clean Old Agents' },
      }
    })
  end
end

return M 