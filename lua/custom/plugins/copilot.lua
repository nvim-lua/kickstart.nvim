return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true

    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598", italic = true })
    vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#83a598", italic = true })
    vim.keymap.set("i", "<C-x>", 'copilot#Accept("")', {
      expr = true,
      silent = true,
      replace_keycodes = false,
    })
  end,
}
