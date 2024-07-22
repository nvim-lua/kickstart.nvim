local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('lua', {
  s('lr', {
    t 'local ',
    i(1, 'module'),
    t ' = require("',
    i(2, 'module'),
    t '")',
  }),
  s('pr', {
    t 'print(',
    i(1, 'text'),
    t ')',
  }),
})
