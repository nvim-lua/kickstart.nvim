-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information


-- Neotree
vim.keymap.set('n', '<space>e', function() vim.cmd.Neotree("toggle") end, { desc = 'Toggle Neotree' })

-- Movement in the editor
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd("h") end, { desc = 'Terminal left window navigation' })
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd("j") end, { desc = 'Terminal down window navigation' })
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd("k") end, { desc = 'Terminal up window navigation' })
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd("l") end, { desc = 'Terminal right window navigation' })

-- Navigate tabs
vim.keymap.set('n', '<S-h>', function() vim.cmd.tabprevious() end, { desc = 'Move to previous tab'})
vim.keymap.set('n', '<S-l>', function() vim.cmd.tabnext() end, { desc = 'Move to next tab'})
vim.keymap.set('n', '<space>tn', function() vim.cmd.tabnew() end, { desc = 'Create new tab' })
vim.keymap.set('n', '<space>tc', function() vim.cmd.tabclose() end, { desc = 'Close tab'})


-- ToggleTerm
vim.keymap.set('n', '<space>tt', function() vim.cmd('ToggleTerm direction=float')  end, { desc = 'Open ToggleTerm'})
vim.keymap.set('n', '<F7>', function() vim.cmd('ToggleTerm')  end, { desc = 'Toggle ToggleTerm'})

-- Lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local pythonREPL = Terminal:new({ cmd = "python3", hidden = true })
local haskellREPL = Terminal:new({ cmd = "ghci", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

function _pythonREPL_toggle()
  pythonREPL:toggle()
end

function _haskellREPL_toggle()
  haskellREPL:toggle()
end

vim.keymap.set('n', '<space>tl', "<cmd>lua _lazygit_toggle()<CR>", { desc = 'Toggle Lazygit', noremap = true, silent = true })
vim.keymap.set('n', '<space>tp', "<cmd>lua _pythonREPL_toggle()<CR>", { desc = 'Toggle Python3 REPL', noremap = true, silent = true })
vim.keymap.set('n', '<space>th', "<cmd>lua _haskellREPL_toggle()<CR>", { desc = 'Toggle GHCI', noremap = true, silent = true })

return {
}
