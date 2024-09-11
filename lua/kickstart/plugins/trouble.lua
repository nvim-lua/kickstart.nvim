return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  -- config = function()
  --   -- local actions = require("telescope.actions")
  --   local trouble = require("trouble.sources.telescope")
  --
  --   local telescope = require("telescope")
  --
  --   telescope.setup({
  --     defaults = {
  --       mappings = {
  --         i = { ["<c-t>"] = trouble.open },
  --         n = { ["<c-t>"] = trouble.open },
  --       },
  --     },
  --   })
  --   vim.keymap.set(
  --     "n",
  --     "<leader>td",
  --     function() require("trouble").toggle("document_diagnostics") end
  --   )
  --   vim.keymap.set(
  --     "n",
  --     "<leader>tq",
  --     function() require("trouble").toggle("quickfix") end
  --   )
  --   vim.keymap.set(
  --     "n",
  --     "<leader>tl",
  --     function() require("trouble").toggle("loclist") end
  --   )
  --   vim.keymap.set(
  --     "n",
  --     "gR",
  --     function() require("trouble").toggle("lsp_references") end
  --   )
  -- end,
  keys = {
    {
      '<leader>tt',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'Diagnostics (Trouble)',
    },
  },
}
