-- NOTE: Keeping this commented for now since I'm not sure of the merit of using this at this moment. I do use the `s` commad relatively frequently and I don't really do much substitutions
return {}

-- return {
--   "gbprod/substitute.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     local substitute = require("substitute")
--
--     substitute.setup()
--
--     -- set keymaps
--     local keymap = vim.keymap -- for conciseness
--
--     vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
--     vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
--     vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
--     vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
--   end,
-- }
