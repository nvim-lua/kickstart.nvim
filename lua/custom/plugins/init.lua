-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
end)

return {
    "folke/zen-mode.nvim",
}
