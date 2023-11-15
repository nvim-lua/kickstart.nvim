return {
  'rmagatti/goto-preview',
  config = function()
    local goto = require('goto-preview')
    goto.setup{}

    vim.keymap.set("n", "gpd", goto.goto_preview_definition, { noremap = true, desc = "Goto Preview Definition" })
    vim.keymap.set("n", "gpt", goto.goto_preview_type_definition, { noremap = true, desc = "Goto Preview Type Definition" })
    vim.keymap.set("n", "gpi", goto.goto_preview_implementation, { noremap = true, desc = "Goto Preview Implementation" })
    vim.keymap.set("n", "gP", goto.close_all_win, { noremap = true, desc = "Close All Preview Windows" })
    vim.keymap.set("n", "gpr", goto.goto_preview_references, { noremap = true, desc = "Goto Preview References" })
  end
}
