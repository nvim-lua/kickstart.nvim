local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quit
map("n", "<leader>q", "<CMD>q<CR>")

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

-- Go to referenece
vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, { desc = '[G]oto [R]reference' })

vim.keymap.set("n", "gpd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpt", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpi", "<CMD>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.keymap.set("n", "gP", "<CMD>lua require('goto-preview').close_all_win()<CR>", { noremap = true })
vim.keymap.set("n", "gpr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })
