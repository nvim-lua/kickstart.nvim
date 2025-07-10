return {
  dir = vim.fn.stdpath('config') .. '/lua/nvim-claude',
  name = 'nvim-claude',
  config = function()
    require('nvim-claude').setup({
      -- Custom config can go here
    })
  end,
  dependencies = {
    'nvim-telescope/telescope.nvim',  -- For agent picker
    'tpope/vim-fugitive',            -- Already installed, for diffs
    'sindrets/diffview.nvim',        -- For advanced diff viewing
    'axkirillov/unified.nvim',       -- For unified diff view with fine-grained hunk staging
  },
} 