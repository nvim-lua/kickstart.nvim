local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- PRINT
    s({trig="pp", snippetType="autosnippet"},
      fmta(
        [[
        print(<>)
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- DO RETURN END
    s({trig="XX", snippetType="autosnippet"},
      fmta(
        [[
        do return end
        ]],
        {
        }
      ),
      {condition = line_begin}
    ),
  }

