return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set("i", "<C-x>", 'copilot#Accept("")', {
      expr = true,
      silent = true,
      replace_keycodes = false,
    })
  end,
}
