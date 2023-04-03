local keymap = vim.keymap

keymap.set("n", "<leader>zn", ":TZNarrow<CR>", { desc = "[Z]en [N]arrow" })
keymap.set("v", "<leader>zn", ":'<,'>TZNarrow<CR>", { desc = "[Z]en [N]arrow" })
keymap.set("n", "<leader>zz", ":TZAtaraxis<CR>", { desc = "[Z]en [z]en" })
