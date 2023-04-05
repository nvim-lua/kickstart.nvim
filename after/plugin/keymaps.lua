local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd [[command ClearBufferExceptCurrent silent! execute "%bd|e#|bd#"]]

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Terminal
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Nvimtree
keymap('n', '<leader>n', ":NvimTreeToggle<cr>", { silent = true, noremap = true, desc = "Toggle [N]vimtree" })

-- UndoTree
keymap('n', '<leader>u', ":UndotreeToggle<cr>", { desc = "Toggle [U]ndo tree" })

-- Move line
keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Search cursor in the middle
keymap('n', 'n', "nzzzv")
keymap('n', 'N', "Nzzzv")

-- replace without copy current selected
-- keymap('x', '<leader>p', "\"_dp")
keymap("x", "<leader>p", [["_dP]])


-- yank to system clipboard
keymap('n', '<leader>y', "\"+y", { desc = "[Y]ank to clipboard" })
keymap('v', '<leader>y', "\"+y", { desc = "[Y]ank to clipboard" })
keymap('n', '<leader>Y', "\"+Y", { desc = "[Y]ank to clipboard" })

-- Open folder in workspace in tmux session
keymap("n", "<leader>op", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "[O]pen [P]roject" })

-- Search cheat sheet
keymap("n", "<leader>ch", "<cmd>silent !tmux neww tmux-cht.sh<CR>", { desc = "[C]heat [S]heet" })

-- replace selected word in the file
keymap("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]eplace words in the file" })

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make [X]ecutable file" })

-- Do nothing
keymap("n", "Q", "<nop>")

-- Bufdelete.vim
keymap("n", "<leader>bd", ":Bdelete<CR>", { desc = "[B]uffer [D]elete" })
keymap("n", "<leader>bw", ":Bwipeout<CR>", { desc = "[B]uffer [W]ipeout" })

-- Delete buffer except current
-- keymap("n", "<leader>be", ":%bd|e#|bd#<CR>", { silent = true, desc = "[B]uffer Delete [E]xcept" })
keymap("n", "<leader>be", ":ClearBufferExceptCurrent<CR>", { silent = true, desc = "[B]uffer Delete [E]xcept" })

-- Vim Be Good
keymap("n", "<leader>vbg", ":VimBeGood<CR>", { desc = "[V]im [B]e [G]ood" })

-- Update source
keymap("n", "<leader><leader>", ":so<CR>")
