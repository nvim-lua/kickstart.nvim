-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Replace word under cursor
vim.keymap.set('n', '<leader>j', '*``cgn', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(0)
  else
    vim.diagnostic.disable(0)
  end
end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- exit insrrt mode with jk
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, desc = '<ESC>' })
-- -- option + a to select all text in a file
vim.keymap.set('n', '<M-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select all' })
--
-- Map the function to a key combination
vim.keymap.set('n', '<leader>te', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
--
-- -- Remap <Leader>x to close the current buffer
vim.api.nvim_set_keymap('n', '<Leader>x', ':bd<CR>', { noremap = true, silent = true })

-- vim.api.nvim_del_keymap('n', '<Leader>l')

-- Function to restart LSP
vim.api.nvim_set_keymap('n', '<leader>L', ':LspRestart<CR>', { noremap = true, silent = true })

-- -- Remap <Leader>l to restart LSP
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>lua restart_lsp()<CR>', { noremap = true, silent = true })

-- Remap leader+f to leader+F
vim.api.nvim_set_keymap('n', '<leader><leader>', '<leader>fF', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<leader>fF', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', '<leader>fT', { noremap = true, silent = true })

vim.keymap.set('n', '<Tab>', '20j', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '20k', { noremap = true, silent = true })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

vim.api.nvim_set_hl(0, '@lsp.type.unused', { link = 'Comment' })

-- jumping lines
-- vim.keymap.del("n", "<S-[>")
-- vim.keymap.del("n", "<S-]>")
vim.keymap.set("n", "<S-[>", "{", { noremap = true, silent = true })  -- Jump up to previous empty line
vim.keymap.set("n", "<S-]>", "}", { noremap = true, silent = true })  -- Jump down to next empty line



vim.keymap.set('n', '<leader>st', function()
  require('telescope.builtin').live_grep({ default_text = "// TODO:" })
end, { desc = "Search for TODO comments" })

vim.keymap.set('n', '<leader>sx', function()
  require('telescope.builtin').live_grep({ default_text = "// FUTURE:" })
end, { desc = "Search for FUTURE comments" })

vim.keymap.set('n', '<leader>si', function()
  require('telescope.builtin').live_grep({ default_text = "// IMPORTANT:" })
end, { desc = "Search for IMPORTANT comments" })

-- Define highlight groups for comment tags
vim.api.nvim_set_hl(0, "FutureHighlight",     { bg = "#3b4252", fg = "#81a1c1", bold = true }) -- Light blue
vim.api.nvim_set_hl(0, "FixmeHighlight",      { bg = "#3b4252", fg = "#bf616a", bold = true }) -- Red
vim.api.nvim_set_hl(0, "NoteHighlight",       { bg = "#3b4252", fg = "#ebcb8b", bold = true }) -- Yellow
vim.api.nvim_set_hl(0, "QuestionHighlight",   { bg = "#3b4252", fg = "#b48ead", bold = true }) -- Purple
vim.api.nvim_set_hl(0, "ImportantHighlight",  { bg = "#3b4252", fg = "#a3be8c", bold = true }) -- Green

