local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- VARIABLE
    s({trig = "vv", wordTrig=false, snippetType="autosnippet"},
      fmta(
        [[
        $(<>)
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- ECHO
    s({trig = "pp", wordTrig=false, snippetType="autosnippet"},
      fmta(
        [[
        @echo 
        ]],
        { }
      )
    ),
    -- PHONY target
    s({trig = "PP", wordTrig=false, snippetType="autosnippet"},
      fmta(
        [[
        .PHONY: 
        ]],
        { }
      )
    ),
  }
