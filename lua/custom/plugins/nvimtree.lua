return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>'),
  vim.keymap.set('n', '<space>e', '<Cmd>wincmd w<CR>'),
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
