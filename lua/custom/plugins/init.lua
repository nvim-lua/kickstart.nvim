-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information


-- Neotree
vim.keymap.set('n', '<space>f', function() vim.cmd.Neotree("toggle") end, { desc = 'Toggle Neotree' })

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

return {
}
