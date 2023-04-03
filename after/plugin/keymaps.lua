local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
keymap('x', '<leader>p', "\"_dp")

-- yank to system clipboard
keymap('n', '<leader>y', "\"+y", { desc = "[Y]ank to clipboard" })
keymap('v', '<leader>y', "\"+y", { desc = "[Y]ank to clipboard" })
keymap('n', '<leader>Y', "\"+Y", { desc = "[Y]ank to clipboard" })

-- Quickfix
keymap('n', "<C-k>", "<cmd>cnext<CR>zz")
keymap('n', "<C-j>", "<cmd>cprev<CR>zz")
keymap('n', "<leader>k", "<cmd>lnext<CR>zz")
keymap('n', "<leader>j", "<cmd>lprev<CR>zz")

-- Open folder in workspace in tmux session
keymap("n", "<leader>op", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "[O]pen [P]roject" })

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
keymap("n", "<leader>be", ":%bd|e#|bd#<CR>", { silent = true, desc = "[B]uffer Delete [E]xcept" })
