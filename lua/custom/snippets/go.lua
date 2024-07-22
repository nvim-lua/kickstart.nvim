local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('go', {
  s('ee', {
    t({ 'panic(' }),
    i(1, 'err'),
    t({ ')' }),
  }),
  s(
    'ei',
    fmt(
      [[
if err != nil {{
    panic({})
}}
      ]],
      { i(1, 'err') }
    )
  ),
})
