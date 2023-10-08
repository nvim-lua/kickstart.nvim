return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup()
    vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })
  end,
  -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  -- event = "User DirOpened",
}
