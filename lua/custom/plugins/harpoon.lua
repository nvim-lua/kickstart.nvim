local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[A]dd harpoon mark' })
vim.keymap.set('n', '<leader>sm', require('telescope').extensions.harpoon.marks, { desc = '[S]earch harpoon [M]' })
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<A-h>', function()
  ui.nav_file(1)
end)
vim.keymap.set('n', '<A-j>', function()
  ui.nav_file(2)
end)
vim.keymap.set('n', '<A-k>', function()
  ui.nav_file(3)
end)
vim.keymap.set('n', '<A-l>', function()
  ui.nav_file(4)
end)

return {}
