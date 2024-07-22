local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('python', {
  s('log', {
    t({ 'LOG.' }),
    i(1, 'level'),
    t({ '(' }),
    i(2, 'message'),
    t({ ')' }),
  }),
})
