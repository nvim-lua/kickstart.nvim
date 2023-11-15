--
--   LUASNIP
local luasnip = require 'luasnip'
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local f = ls.function_node
-- HELPER
-- 			:p		expand to full path
-- 			:h		head (last path component removed)
-- 			:t		tail (last path component only)
-- 			:r		root (one extension removed)
-- 			:e		extension only
-- 			:lua print(vim.fn.expand '%:t') -- actual file only
local full_filename = function()
  return { vim.fn.expand '%:p' }
end

local filename = function()
  return { vim.fn.expand '%:t' }
end

-- SNIPS
ls.add_snippets('all', { -- `all` all filetypes, `lua` only lua ft
  s('luaxx', { t 'this is lua file!' }),
  s('sep', t { '---------------' }),

  -- snip: add file's filename
  s({
    trig = "filename",
    namr = "Filename",
    dscr = "insert file name",
  }, {
    f(filename, {}),
  }),
  s({
    trig = "long filename",
    namr = "long Filename",
    dscr = "insert canonical file name",
  }, {
    f(full_filename, {}),
  }),
})
---------------
-- next line:  allows use of snippet collection in vscode (??)
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}
