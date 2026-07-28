-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  { -- Sticky header showing the enclosing scope (parent keys in JSON/YAML, etc.)
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      max_lines = 5, -- how many context lines to show at most (0 = unlimited)
      multiline_threshold = 1, -- collapse multiline nodes to a single line
    },
    keys = {
      { '[c', function() require('treesitter-context').go_to_context(vim.v.count1) end, desc = 'Jump to [c]ontext (upper key)' },
    },
  },
}
