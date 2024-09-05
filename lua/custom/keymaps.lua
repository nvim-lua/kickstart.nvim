vim.keymap.set('n', '<leader>oo', ':ObsidianOpen<cr>')
vim.keymap.set('n', '<leader>on', ':ObsidianNew<cr>')
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<cr>')
vim.keymap.set('n', '<leader>oi', ':e oil:///mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Inbox/<cr>')
vim.keymap.set('n', '<leader>od', ':e oil:///mnt/c/Users/jkosk/OneDrive/Documents/Artemis/<cr>')
-- vim.keymap.set('n', '<leader>om', ':Move Notes<cr>:e oil:///mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Inbox/<cr>')


vim.keymap.set('n', '<leader>om', function()
  vim.api.nvim_feedkeys('yy', 'n', false)
  vim.cmd ':e oil:///mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Notes/'
  vim.api.nvim_feedkeys('p', 'n', false)
  vim.cmd ':w'
  vim.cmd ':e oil:///mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Inbox/'
end)


vim.keymap.set('n', '<leader>ot', function()
  vim.cmd ':ObsidianToday'
  vim.api.nvim_feedkeys('G', 'n', false)
end)
vim.keymap.set('n', '<leader>ol', ':ObsidianFollowLink')
vim.keymap.set('n', '<leader>oe', function()
  local fileName = os.time(os.date '!*t') .. '.excalidraw.md'

  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = (line:sub(0, pos) .. '![[' .. fileName .. ']]' .. line:sub(pos + 1))
  vim.api.nvim_set_current_line(nline)

  vim.cmd ':w'
  vim.cmd(
    ':!cp /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Templates/excalidraw.md /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Excalidraw/' ..
    fileName)
  vim.cmd(':e /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Excalidraw/' .. fileName)
  vim.cmd(':ObsidianOpen /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Excalidraw/' .. fileName)
end)

vim.keymap.set('n', '<leader>dd', ':Dashboard<cr>:echo<cr>')

vim.keymap.set('n', '<leader>mp', ':MusicPlay spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mn', ':MusicNext spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mb', ':MusicPrev spotify<cr>:echo<cr>')
vim.keymap.set('n', '<leader>mc', ':MusicCurrent spotify<cr>:echo<cr>')

vim.keymap.set('n', '<leader>oc', function()
  require('easypick').actions.nvim_commandf(':Move /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Classes/%s')
  require('easypick').one_off('ls /mnt/c/Users/jkosk/OneDrive/Documents/Artemis/Classes/')
end)

vim.keymap.set('n', '<leader>op', ':ObsidianTag<cr>')
