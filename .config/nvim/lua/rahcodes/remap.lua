local Remap = require("rahcodes.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local nmap = Remap.nmap

nnoremap("<leader>pv", "<cmd>Ex<CR>")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
vim.keymap.set("n", "<leader>*", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<leader>m", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
-- vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set("n", "<leader><leader>", builtin.git_files, {})

-- Null Ls
nnoremap("<leader>lf", ":lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>")
nnoremap("<leader>lF", ":lua vim.lsp.buf.range_format({ timeout_ms = 2000 })<CR>")

-- Git Fugitive
nnoremap("<leader>gs", ":G<CR>")
nnoremap("<leader>gh", ":diffget //3<CR>")
nnoremap("<leader>gu", ":diffget //2<CR>")
nnoremap("<leader>gc", ":GCheckout<CR>")
nnoremap("<leader>ga", ":G add %:p<CR><CR>")
nnoremap("<leader>gc", ":G commit -v -q<CR>")
nnoremap("<leader>gt", ":G commit -v -q %:p<CR>")
nnoremap("<leader>gca", ":G commit --amend --no-edit<CR>")
nnoremap("<leader>gff", ":G ff<CR>")
nnoremap("<leader>gfo", ":G fetch origin<CR>")
nnoremap("<leader>gd", ":Gdiff<CR>")
nnoremap("<leader>ge", ":Gedit<CR>")
nnoremap("<leader>gr", ":Gread<CR>")
nnoremap("<leader>gw", ":Gwrite<CR><CR>")
nnoremap("<leader>gl", ":silent! Glog<CR>:bot copen<CR>")
nnoremap("<leader>gp", ":Ggrep<Space>")
nnoremap("<leader>gm", ":Gmove<Space>")
-- nnoremap("<leader>gb", ":G branch<Space>")
nnoremap("<leader>go", ":G checkout<Space>")
nnoremap("<leader>gps", ":Dispatch! git push<CR>")
nnoremap("<leader>gpl", ":Dispatch! git pull<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- nnoremap("/", "/\v")
-- vnoremap("/", "/\v")
nnoremap("<leader>`", ":noh<cr>")

-- No Cheating
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")

-- No weird line jumps
nnoremap("j", "gj")
nnoremap("k", "gk")

-- Copy to system clipboard
vnoremap("<leader>y", '"*y')
vnoremap("<leader>yy", '"+y')

-- Move buffers
nmap("sp", ":bprev<Return>")
nmap("sn", ":bnext<Return>")
