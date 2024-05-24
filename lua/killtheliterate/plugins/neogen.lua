return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require('neogen').setup {}
    vim.keymap.set('n', '<leader>nf', ":Neogen func<CR>", { noremap = true, desc = '[D]ocument [F]unction' })
  end,
}
