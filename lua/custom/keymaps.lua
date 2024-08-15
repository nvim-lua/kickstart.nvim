vim.keymap.set('n', '<leader>oo', ':ObsidianOpen<cr>')
vim.keymap.set('n', '<leader>on', ':ObsidianNew<cr>')
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<cr>')
vim.keymap.set('n', '<leader>oi', ':e oil://~/Documents/Obsidian/Artemis/Inbox/<cr>')
vim.keymap.set('n', '<leader>od', ':e oil://~/Documents/Obsidian/Artemis/<cr>')
vim.keymap.set('n', '<leader>om', ':Move Notes<cr>:e oil://~/Documents/Obsidian/Artemis/Inbox/<cr>')
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd ':ObsidianToday'
  vim.api.nvim_feedkeys('G', 'n', false)
end)
vim.keymap.set('n', '<leader>ol', ':ObsidianFollowLink')
vim.keymap.set('n', '<leader>oe', function()
  local fileName = os.time(os.date '!*t') .. '.excalidraw.md'

  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = (line:sub(0, pos) .. '[[' .. fileName .. ']]' .. line:sub(pos + 1))
  vim.api.nvim_set_current_line(nline)

  vim.cmd ':w'
  vim.cmd(':!cp ~/Documents/Obsidian/Artemis/Templates/excalidraw.md ~/Documents/Obsidian/Artemis/Excalidraw/' .. fileName)
  vim.cmd(':e ~/Documents/Obsidian/Artemis/Excalidraw/' .. fileName)
  vim.cmd(':ObsidianOpen ~/Documents/Obsidian/Artemis/Excalidraw/' .. fileName)
end)

vim.keymap.set('n', '<leader>dd', ':Dashboard<cr>:echo<cr>')

vim.keymap.set('n', '<leader>mp', ':MusicPlay spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mn', ':MusicNext spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mb', ':MusicPrev spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mc', ':MusicCurrent spotify<cr>:echo<cr>')
