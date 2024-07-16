vim.opt.relativenumber = true
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>')
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gp', ':Git pull<CR>')
vim.keymap.set('n', '<leader>gpsh', ':Git push<CR>')
vim.keymap.set('n', 'gh', '<cmd>diffget //2<CR>')
vim.keymap.set('n', 'gl', '<cmd>diffget //3<CR>')

-- LSP testing
local client_id = vim.lsp.start_client {
  name = 'LSP Playground',
  cmd = { '/home/gilad/dev/lsp-playground/main' },
  on_attach = function() end,
}

if not client_id then
  vim.notify "hey, you didn't do the client thing good"
  return
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local success = vim.lsp.buf_attach_client(0, client_id)
    if not success then
      vim.notify 'failed to attach client'
    end
  end,
})
