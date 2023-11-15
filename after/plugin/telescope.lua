-- Go to referenece
-- vim.keymap.del("n", "gr")
-- vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, { desc = '[G]oto [R]reference', noremap = false })
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
