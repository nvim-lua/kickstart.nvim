--[[ Split cmd ]]
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.keymap.set('n', '||', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '--', '<cmd>split<cr>', { desc = 'Horinzontal Split' })

-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to the left' })
-- vim.keymap.set('n', '<C-j>', '<C-w>', { desc = 'Navigate below' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate up' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate right' })

vim.keymap.set('n', '<leader>sh', '<C-w>h', { desc = 'Navigate to the left' })
vim.keymap.set('n', '<leader>sw', '<C-w>', { desc = 'Navigate below' })
vim.keymap.set('n', '<leader>sk', '<C-w>k', { desc = 'Navigate up' })
vim.keymap.set('n', '<leader>sl', '<C-w>l', { desc = 'Navigate right' })

vim.keymap.set('n', '<leader>hh', ':vertical resize +3<CR>', { silent = true })
vim.keymap.set('n', '<leader>ll', ':vertical resize -3<CR>', { silent = true })
vim.keymap.set('n', '<leader>kk', ':resize +3<CR>', { silent = true })
vim.keymap.set('n', '<leader>jj', ':resize -3<CR>', { silent = true })

vim.g.original_size = nil

function Toggle_maximize_pane()
  local winnr = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(winnr)
  local height = vim.api.nvim_win_get_height(winnr)
  if vim.g.original_size == nil then
    vim.g.original_size = { width, height }
    vim.api.nvim_win_set_width(winnr, vim.o.columns)
    vim.api.nvim_win_set_height(winnr, vim.o.lines)
  else
    vim.api.nvim_win_set_width(winnr, vim.g.original_size[1])
    vim.api.nvim_win_set_height(winnr, vim.g.original_size[2])
    vim.g.original_size = nil
  end
end

vim.keymap.set('n', '<C-m>', '<cmd>lua Toggle_maximize_pane()<CR>', { noremap = true, desc = 'Maximize Current Split' })
