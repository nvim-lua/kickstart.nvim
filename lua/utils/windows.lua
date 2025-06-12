-- Tab management keys
-- F1-Prev, F2-Next, F3-New, F4-Close
--
local function safe_tabclose()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call('win_findbuf', bufnr)
  local modified = vim.bo[bufnr].modified

  if vim.fn.tabpagenr '$' == 1 then
    -- last tab, no-op
    return
  elseif modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = 'Buffer modified, are you sure? ',
    }, function(input)
      if input == 'y' then
        vim.cmd 'tabclose'
      end
    end)
  else
    vim.cmd 'tabclose'
  end
end
vim.keymap.set('t', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('t', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('t', '<F3>', '<C-\\><C-n>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('t', '<F5>', '<C-\\><C-n><Esc>:tab new<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('n', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('n', '<F3>', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('n', '<F5>', ':tab term<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('i', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('i', '<F3>', '<Esc>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('i', '<F5>', '<Esc>:tab term<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wp', vim.cmd.tabn, { desc = '[p]revious' })
vim.keymap.set('n', '<leader>wn', vim.cmd.tabp, { desc = '[n]ext' })
vim.keymap.set('n', '<leader>wo', vim.cmd.tabnew, { desc = '[o]pen' })
vim.keymap.set('n', '<leader>wc', safe_tabclose, { desc = '[c]lose' })
