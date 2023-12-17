local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- (conflict with <leader>pw) keep copied stuffs in the buffer when pasting it
-- map("n", "<leader>p", "\"_dP")

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

map("n", "<leader>q", "<CMD>q<CR>")
-- Quit

-- Exit insert mode
map("i", "jj", "<ESC>")

-- Window split
map("n", "<leader>sv", "<CMD>vsplit<CR>")
map("n", "<leader>sh", "<CMD>split<CR>")

-- Window resize
map("n", "<c-Left>", "<c-w><")
map("n", "<c-Right>", "<c-w>>")
map("n", "<c-Up>", "<c-w>+")
map("n", "<c-Down>", "<c-w>-")

-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv-gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Buffer
map("n", "<TAB>", "<CMD>bnext<CR>")
map("n", "<s-TAB>", "<CMD>bprevious<CR>")

map("n", "Q", "<Nop>")
map("n", "<c-f>", "<CMD>silent !tmux new tmux-sessionizer<CR>")

-- LSP format
map("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- Search and replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- Reset highlight
map("n", "<CR>", "<CMD>noh<CR><CR>")

-- Hover documentation
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", '<C-k>', vim.lsp.buf.signature_help, { desc = '[S]ignature [D]ocumentation' })

-- spell check
vim.keymap.set("n", "<F3>", "<CMD>set spell!<CR>", { silent = true, desc = 'Toggle spell check' })
vim.keymap.set("i", "<F3>", "<C-O>:set spell!<CR>", { silent = true, desc = 'Toggle spell check' })

-- Hide windows
vim.keymap.set("n", "<leader>hw", "<CMD>only<CR>", { silent = true, desc = 'Hide windows' })

-- delete buffer
vim.api.nvim_set_keymap('n', '<leader>db', ':bdelete!<CR>',
  { noremap = true, silent = true, desc = '[D]elete current [B]uffer' })
