local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    s({trig = "doc"},
      fmt(
        [[
        # NAME
        # 		{} - {}
        # 
        # SYNOPSIS
        # 		{} {}
        ]],
        {
          i(1, "name"),
          i(2, "description"),
          rep(1),
          i(3, "usage"),
        }
      ),
      {condition = line_begin}
    ),
    -- /bin/bash shebang
    s({trig = "!!", snippetType="autosnippet"},
      {t("#!/bin/bash")},
      {condition = line_begin}
    ),
    s({trig = "fl", snippetType="autosnippet"},
      fmt(
        [[
        for {} in {}; do
          {}
        done
        ]],
        {
          i(1),
          i(2),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    s({trig = "read"},
      fmt(
        [=[
          while read line
          do
            [[ -z "${line}" ]] && continue
            [[ "${line}" = \#* ]] && continue
            echo "${line}"
            ()
          done < ()
        ]=],
        {
          i(2),
          i(1, "myfile.txt")
        },
        { delimiters = "()"}
      ),
      {condition = line_begin}
    ),
    -- IF STATEMENT
    s({trig = "iff", snippetType="autosnippet"},
      fmta(
        [=[
          if [[ <> ]]; then
            <>
          fi
        ]=],
        {
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- VARIABLE
    s({trig = "vv", wordTrig=false, snippetType="autosnippet"},
      fmta(
        [[
        ${<>}
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- ECHO
    s({trig = "pp", snippetType="autosnippet"},
      fmta(
        [[
        echo "<>"
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    s({trig = "ext"},
      fmta(
        [[
        ${<>%.<>}
        ]],
        {
          i(1, "var"),
          i(2, "ext"),
        }
      )
    ),
    s({trig = "XX", snippetType="autosnippet"},
    {t("exit")},
    {condition = line_begin}
    ),
  }
