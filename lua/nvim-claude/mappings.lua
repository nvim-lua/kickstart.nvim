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
        i = { 'List files with diffs' },
      },
      ['<leader>i'] = {
        name = 'Inline Diffs',
        a = { 'Accept current hunk' },
        r = { 'Reject current hunk' },
        A = { 'Accept all hunks in file' },
        R = { 'Reject all hunks in file' },
        AA = { 'Accept ALL diffs in ALL files' },
        q = { 'Close inline diff' },
        l = { 'List files with diffs' },
      }
    })
  end
  
  -- Global keymaps for navigating between files with Claude diffs
  vim.keymap.set('n', ']f', function()
    local inline_diff = require('nvim-claude.inline-diff')
    inline_diff.next_diff_file()
  end, {
    desc = 'Next file with Claude diff',
    silent = true
  })
  
  vim.keymap.set('n', '[f', function()
    local inline_diff = require('nvim-claude.inline-diff')
    inline_diff.prev_diff_file()
  end, {
    desc = 'Previous file with Claude diff',
    silent = true
  })
  
  -- Global keymap for listing files with diffs
  vim.keymap.set('n', prefix .. 'i', function()
    local inline_diff = require('nvim-claude.inline-diff')
    inline_diff.list_diff_files()
  end, {
    desc = 'List files with Claude diffs',
    silent = true
  })
  
  -- Global keymap to accept all diffs across all files
  vim.keymap.set('n', '<leader>iAA', function()
    local inline_diff = require('nvim-claude.inline-diff')
    inline_diff.accept_all_files()
  end, {
    desc = 'Accept ALL Claude diffs in ALL files',
    silent = true
  })
end

return M 