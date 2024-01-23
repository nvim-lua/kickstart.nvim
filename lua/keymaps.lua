-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

local keymap = vim.keymap

-- removes highlight on / 
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- deletes character but does not copy into a registar 
keymap.set("n", "x", '"_x"')

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically 
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally 
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width  
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window 

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- vim maximizer 
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Format File
vim.api.nvim_set_keymap('n', '<S-F>', ':Format<CR>', { noremap = true, silent = true })
