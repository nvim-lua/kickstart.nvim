local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- tex.sprint
    s({trig = "tpp", snippetType="autosnippet"},
      fmta(
      [[
        tex.sprint(<>)
      ]],
        {
          d(1, get_visual),
        }
      )
    ),
  }
