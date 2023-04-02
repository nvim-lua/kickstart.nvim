local set = vim.opt

set.colorcolumn = "80,120"
set.cursorline = true
set.expandtab = true
set.list = true
set.swapfile = false
set.writebackup = false
set.wrap = false
-- vim.o.sessionoptions = "resize,winpos,winsize,buffers,tabpages,folds,curdir,help"
set.shiftwidth = 2
-- vim.o.showmode = true
set.splitbelow = true
set.splitright = true
set.tabstop = 2
set.textwidth = 80

-- prev/next tab
vim.keymap.set('n', 'H', 'gT', { desc = 'Tab Left' })
vim.keymap.set('n', 'L', 'gt', { desc = 'Tab Right' })

-- line bubbling

-- nnoremap <C-j> :m .+1<CR>==
-- nnoremap <C-k> :m .-2<CR>==
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true, desc = 'Bubble Up' }) -- conflicts with "signature help" from LSP

-- inoremap <C-j> <ESC>:m .+1<CR>==gi
-- inoremap <C-k> <ESC>:m .-2<CR>==gi
vim.keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', { noremap = true, desc = 'Bubble Up' })

-- vnoremap <C-j> :m '>+1<CR>gv=gv
-- vnoremap <C-k> :m '<-2<CR>gv=gv
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, desc = 'Bubble Up' })

vim.o.inccommand = "nosplit"

vim.diagnostic.config({
  virtual_text = {
    -- source = "always",  -- Or "if_many"
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

local signs = { Error = "✗", Warn = "⚠", Hint = "➤", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- null-ls

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
})

-- nvim-autopairs + nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- vim: ts=2 sts=2 sw=2 et
