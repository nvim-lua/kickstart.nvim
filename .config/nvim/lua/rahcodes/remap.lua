local Remap = require("rahcodes.keymap")
local nmap = Remap.nmap

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- don't bork paste buffer when pasting
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "/", "/\v")
-- vim.keymap.set("v", "/", "/\v")
vim.keymap.set("n", "<leader>`", ":noh<cr>")

-- No Cheating
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

-- No weird line jumps
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"*y')
vim.keymap.set("v", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>yy", '"+y')
vim.keymap.set("v", "<leader>yy", '"+y')

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Move buffers
nmap("sp", ":bprev<Return>")
nmap("sn", ":bnext<Return>")

-- Quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Save
nmap("<C-s>", ":wa<Return>")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>m", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").git_files, { desc = "[ ] Find git files" })
vim.keymap.set("n", "<leader>ps", function()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches, { desc = "[G]it [B]ranches" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
