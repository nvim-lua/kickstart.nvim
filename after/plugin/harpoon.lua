local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hn", function() ui.nav_next() end, { desc = "[H]arpoon [N]ext" })
vim.keymap.set("n", "<leader>hp", function() ui.nav_prev() end, { desc = "[H]arpoon [P]revious" })
