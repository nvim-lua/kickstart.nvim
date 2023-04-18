local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: add file" })
vim.keymap.set("n", "<leader>hf", ui.toggle_quick_menu, { desc = "Harpoon: toggle quick menu" })
