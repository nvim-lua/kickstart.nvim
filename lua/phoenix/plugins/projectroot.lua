return {
  "dbakker/vim-projectroot",
  config = function()
    vim.keymap.set(
      "n",
      "<C-f>",
      ":<C-u>ProjectRootExe lua require('telescope.builtin').live_grep({debounce=100})<cr>",
      { noremap = true, silent = true })
  end
}
