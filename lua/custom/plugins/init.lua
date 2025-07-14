vim.g.netrw_banner = 0 -- disable topbar
-- vim.g.netrw_browse_split = 4 -- open in prior buffer/window
-- -- vim.g.netrw_altv = 1 -- open fle splits to the right
vim.g.netrw_liststyle = 3 -- tree view
-- vim.g.netrw_winsize = 25 -- length of the window
vim.diagnostic.config {
  virtual_text = {
    -- source = "always",  -- Or "if_many"
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

-- vim.diagnostic.config {
--   virtual_text = false,
-- }
-- never use tabs
vim.o.expandtab = true

local set = vim.opt_local
set.shiftwidth = 2
vim.o.shiftwidth = 2
return {}
