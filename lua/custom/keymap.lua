-- Custom keychains
require('which-key').register {
  ['<leader>p'] = { name = '[P]ython', _ = 'which_key_ignore' },
}
-- Undo
vim.keymap.set('n', '<leader>su', require('telescope').extensions.undo.undo, { desc = '[S]earch [U]ndo' })

-- Lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = '[G]it Lazy[G]it' })

-- Debug
vim.keymap.set({ 'n', 'v' }, '<Leader>pm', function()
  require('dap-python').test_method()
end, { desc = '[P]ython Debug [M]ethod' })
vim.keymap.set({ 'n', 'v' }, '<Leader>pc', function()
  require('dap-python').test_class()
end, { desc = '[P]ython Debug [C]lass' })
vim.keymap.set('v', '<Leader>k', function()
  require('dapui').eval()
end, { desc = 'Debug: Eval' })

-- Navigate buffers
vim.keymap.set('n', '<leader>l', ':ls<CR>:b<space>', { desc = 'Select buffer' })

-- Make
vim.keymap.set('n', '<leader>m', ':make <CR>', { desc = '[M]ake' })

-- Telescope undo
vim.keymap.set('n', '<leader>su', require('telescope').extensions.undo.undo, { desc = '[S]earch [U]ndo' })

-- Compile markdown to html with pandoc
-- vim.keymap.set(
--   'n',
--   '<C-H>',
--   ":! pandoc '%:p' -o /tmp/'%:p:t'.html --template=easy_template.html --toc && /mnt/c/Program\\  Files/Mozilla\\ Firefox/ /tmp/'%:p:t'.html &<CR><CR>",
--   { desc = 'Build [M]arkdown to HTML' }
-- )

-- Spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})
