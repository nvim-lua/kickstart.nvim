vim.keymap.set('n', '<C-t>', function()
  -- Get the current file's directory (handles unsaved files too)
  local cwd = vim.fn.expand '%:p:h'
  if cwd == '' then
    cwd = vim.fn.getcwd() -- fallback to current working dir
  end

  -- Open a horizontal split and terminal
  vim.cmd 'split'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'

  -- Safely cd into the folder, even if it has spaces
  vim.fn.chansend(vim.b.terminal_job_id, 'cd "' .. cwd .. '"\n')
end, { desc = "Open terminal in current file's directory" })

local harpoon = require 'harpoon'

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = 'Add file to Harpoon' })
vim.keymap.set('n', '<leader>h', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Toggle Harpoon menu' })

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end)

-- In your keybindings configuration (e.g., lua/config/keymaps.lua or init.lua)
vim.keymap.set('n', '<leader>w', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
