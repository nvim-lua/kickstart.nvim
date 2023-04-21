local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hn", function() ui.nav_next() end, { desc = "[H]arpoon [N]ext" })
vim.keymap.set("n", "<leader>hp", function() ui.nav_prev() end, { desc = "[H]arpoon [P]revious" })

vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "[H]arpoon [1]" })
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "[H]arpoon [2]" })
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "[H]arpoon [3]" })
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "[H]arpoon [4]" })
vim.keymap.set("n", "<leader>h5", function() ui.nav_file(5) end, { desc = "[H]arpoon [5]" })
vim.keymap.set("n", "<leader>h6", function() ui.nav_file(6) end, { desc = "[H]arpoon [6]" })
