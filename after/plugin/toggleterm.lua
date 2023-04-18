local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = 'lazygit', hidden = true })

vim.keymap.set('n', '<leader>g', function()
    lazygit:toggle()
end, { noremap = true, silent = true, desc = 'Toggle lazygit' })
