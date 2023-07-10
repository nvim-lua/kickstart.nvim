-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"


-- Neotree
vim.keymap.set('n', '<space>f', function() vim.cmd.Neotree("toggle") end, { desc = 'Toggle Neotree' })

-- Movement in the editor
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd("h") end, { desc = 'Terminal left window navigation' })
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd("j") end, { desc = 'Terminal down window navigation' })
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd("k") end, { desc = 'Terminal up window navigation' })
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd("l") end, { desc = 'Terminal right window navigation' })

-- Navigate tabs
vim.keymap.set('n', '<S-h>', function() vim.cmd.tabprevious() end, { desc = 'Move to previous tab'})
vim.keymap.set('n', '<S-l>', function() vim.cmd.tabnext() end, { desc = 'Move to next tab'})
vim.keymap.set('n', '<space>tn', function() vim.cmd.tabnew() end, { desc = 'Create new tab' })
vim.keymap.set('n', '<space>tc', function() vim.cmd.tabclose() end, { desc = 'Close tab'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Replace the current word with new stuff
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file execuable"})

return {
}
