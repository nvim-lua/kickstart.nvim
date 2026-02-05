vim.g.netrw_banner = 0 -- disable topbar
vim.g.netrw_liststyle = 3 -- tree view
vim.diagnostic.config {
  virtual_text = {
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = true, -- Or "if_many"
  },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldenable = false

-- copy current buffer path to "+
vim.keymap.set('n', '<leader>yb', '<cmd>let @+ = expand("%")<CR>', { desc = 'yank to plus register current relative path' })

-- https://devpad.net/blog/upgrading-nvim-v010-to-v011
vim.opt.completeopt = { 'menuone', 'fuzzy', 'noinsert', 'preview' }
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- never use tabs
vim.o.expandtab = true
-- evitar folds
vim.o.foldlevelstart = 99

local set = vim.opt_local
set.shiftwidth = 2
vim.o.shiftwidth = 2
return {}
