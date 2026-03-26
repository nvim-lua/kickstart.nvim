return { -- File operations (rename, move etc...) improvements for auto renaming imports
  'antosha417/nvim-lsp-file-operations',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Uncomment whichever supported plugin(s) you use
    -- "nvim-tree/nvim-tree.lua",
    'nvim-neo-tree/neo-tree.nvim',
    -- "simonmclean/triptych.nvim"
  },
  config = function()
    require('lsp-file-operations').setup()
  end,
}
