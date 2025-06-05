vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
    local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy '+'
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy '*'
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
    local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy '+'
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy '*'
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})

vim.keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end)

vim.keymap.set(
  'n',
  'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end
)

vim.api.nvim_set_keymap('t', '<C-Space>', '<C-\\><C-n>', { noremap = true })

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'terraform',
  callback = function()
    vim.bo.commentstring = '# %s'
  end,
})

require('lazy').setup {

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
