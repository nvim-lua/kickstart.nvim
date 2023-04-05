local keymap = vim.keymap.set

-- Quickfix
keymap("n", "<leader>qq", ":TroubleToggle quickfix<CR>", { desc = "[Q]uickfix [Q]uick" })
keymap("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "[Q]uick [N]ext" })
keymap("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "[Q]uick [P]revious" })

-- Location List
keymap("n", "<leader>ll", ":TroubleToggle loclist<CR>", { desc = "[L]ocation [L]ist" })
keymap("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = "[L]ocation [N]ext" })
keymap("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = "[L]ocation [P]revious" })
