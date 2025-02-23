return { 
  'folke/todo-comments.nvim', 
  event = 'VimEnter', 
  dependencies = { 'nvim-lua/plenary.nvim' }, 
  opts = { 
    signs = false,
    -- Keymaps are handled in core/keymaps.lua
  } 
}
