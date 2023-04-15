local set = vim.opt

set.colorcolumn = "80,120"
set.cursorline = true
set.expandtab = true
set.list = true
set.shiftwidth = 2
-- set.spell = true
-- set.spelllang = 'en_us'
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 2
set.textwidth = 80
set.wrap = false
set.writebackup = false

vim.o.inccommand = "nosplit"

-- prev/next tab
vim.keymap.set('n', 'H', 'gT', { desc = 'Tab Left' })
vim.keymap.set('n', 'L', 'gt', { desc = 'Tab Right' })

-- line bubbling
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true, desc = 'Bubble Up' }) -- conflicts with "signature help" from LSP
vim.keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', { noremap = true, desc = 'Bubble Up' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, desc = 'Bubble Down' })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, desc = 'Bubble Up' })

-- additional telescope triggers
vim.keymap.set('n', '<C-t>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<C-g>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    source = false,
    prefix = '●',
    format = function()
      return ""
    end,
  },
  float = {
    source = "always",
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format(
          '%s [%s]',
          diagnostic.message,
          diagnostic.user_data.lsp.code
        )
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
  },
})

local signs = { Error = "✗", Warn = "⚠", Hint = "➤", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim: ts=2 sts=2 sw=2 et
