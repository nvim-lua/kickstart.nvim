-- [[ General Keymaps ]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Stop yanking on paste
vim.keymap.set('x', 'p', 'P')

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

-- Esc functionality
vim.keymap.set("n", "<Esc>", function()
  -- Clear terminal notification below
  vim.notify("")
  -- Removes highlight search
  vim.cmd.noh()

  vim.cmd(':silent! Neotree cancel<cr>')
end, { silent = true })

-- Split resize
vim.keymap.set('n', '<C-j>', ':res +1<cr>', { desc = 'Resize split' })
vim.keymap.set('n', '<C-k>', ':res -1<cr>', { desc = 'Resize split' })
vim.keymap.set('n', '<C-h>', ':vertical res -1<cr>', { desc = 'Resize split vertically' })
vim.keymap.set('n', '<C-l>', ':vertical res +1<cr>', { desc = 'Resize split vertically' })
