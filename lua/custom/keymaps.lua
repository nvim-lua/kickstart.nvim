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

vim.keymap.set('n', '<leader>dd', ':Dashboard<cr>:echo<cr>')
