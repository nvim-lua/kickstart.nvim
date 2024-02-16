-- thanks https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua

-- move hightlighted code
vim.keymap.set("v", "C-P", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "C-N", ":m '<-2<CR>gv=gv")

-- J appends line below to current line but cursor doesn't move
vim.keymap.set("n", "J", "mzJ`z")

-- keeps cursos in middle when moving/searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- paste without adding deleted text to register
vim.keymap.set("x", "<leader>p", [["_dP]])
-- delete without adding deleted text to register
vim.keymap.set("x", "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
-- yank/delete into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- dont press this
vim.keymap.set("n", "Q", "<nop>")

-- quickfix nav
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- find/replace word you're on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make script executable
vim.keymap.set("n", "<leader>+", "<cmd>!chmod +x %<CR>", { silent = true })

--trouble.nvim
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = 'Open Trouble' })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
  { desc = 'Trouble [w]orkspace Diagnostics' })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
  { desc = 'Trouble [d]ocument Diagnostics' })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = 'Trouble [q]uickfix' })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = 'Trouble [l]oclist' })
vim.keymap.set("n", "<leader>xR", function() require("trouble").toggle("lsp_references") end,
  { desc = 'Trouble [g]o to [R]eferences' })

-- undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
