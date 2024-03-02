local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- ALERT
    s({trig = "aa", snippetType="autosnippet"},
      fmta(
        [[
        alert(<>);
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- LOG TO CONSOLE
    s({trig = "PP", snippetType="autosnippet"},
      fmta(
        [[
        console.log(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
  }





