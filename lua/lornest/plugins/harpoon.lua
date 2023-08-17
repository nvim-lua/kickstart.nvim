return {
  'ThePrimeagen/harpoon',
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>m", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<C-h>", function() ui.nav_prev() end)
    vim.keymap.set("n", "<C-j>", function() ui.nav_next() end)
  end,
}
