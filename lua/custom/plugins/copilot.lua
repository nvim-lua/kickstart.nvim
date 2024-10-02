return {
  {
    'github/copilot.vim',
    init = function()
      -- vim.g.copilot_enabled = false
      vim.keymap.set('i', '<M-;>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<M-/>', '<Plug>(copilot-dismiss)')
    end,
    --
  },
}
