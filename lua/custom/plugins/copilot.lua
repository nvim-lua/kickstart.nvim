return {
  {
    'github/copilot.vim',
    -- let g:copilot_enabled = v:false
    init = function()
      -- vim.g.copilot_enabled = false
      vim.keymap.set('i', '<M-;>', '<Plug>(copilot-accept-word)')
    end,
    --
  },
}
