local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- HEADER
    s({trig="h([123456])", regTrig=true, wordTrig=false, snippetType="autosnippet"},
      fmt(
        [[
          <h{} class="{}">{}</h{}>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(2),
          d(1, get_visual),
          f( function(_, snip) return snip.captures[1] end ),
        }
      ),
      {condition = line_begin}
    ),
    -- GENERTIC INLINE ELEMENT
    s({trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
          {}<{} class="{}">{}</{}>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(1),
          i(2),
          d(3, get_visual),
          rep(1)
        }
      )
    ),
    -- GENERTIC TAG
    s({trig = "TT", snippetType="autosnippet"},
      fmt(
        [[
          <{}{}>
            {}
          </{}>
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
          rep(1)
        }
      )
    ),
    -- SPAN ELEMENT
    s({trig = "([^%l])ss", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
          {}<span class="{}">{}</span>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(2),
          d(1, get_visual),
        }
      )
    ),
    -- FORM TAG
    s({trig = "ff", snippetType="autosnippet"},
      fmt(
        [[
          <form{}>
            {}
          </form>
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PRE TAG
    s({trig = "prr", snippetType="autosnippet"},
      fmt(
        [[
          <pre>
            {{{{{}}}}}
          </pre>
        ]],
        {
          d(1, get_visual)
        }
      )
    ),
    -- PARAGRAPH
    s({trig="pp", snippetType="autosnippet"},
      fmt(
        [[
          <p class="{}">{}</p>
        ]],
        {
          i(2),
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- IMG
    s({trig="imgg", snippetType="autosnippet"},
      fmt(
        [[
          <img src="{}" alt="{}" class="{}"/>
        ]],
        {
          d(1, get_visual),
          i(2),
          i(3)
        }
      )
    ),
    -- CLASS
    s({trig=";c", snippetType="autosnippet"},
      fmt(
        [[
          class="{}"
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- UNORDERED LIST
    s({trig="ull", snippetType="autosnippet"},
      fmt(
        [[
          <ul>
            <li {}>
              {}
            </li>{}
          </ul>
        ]],
        {
          i(2),
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- LIST ITEM
    s({trig="ii", snippetType="autosnippet"},
      fmt(
        [[
            <li {}>
              {}
            </li>
        ]],
        {
          i(2),
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- DOCUMENT TEMPLATE
    s({trig="base"},
      fmt(
        [[
        <!doctype HTML>
        <html lang="en">
          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>{}</title>
          </head>
          <body>
            {}
          </body>
        </html>
        ]],
        {
          i(1, "FooBar"),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- SCRIPT
    s({trig = "SS", snippetType="autosnippet"},
      fmt(
        [[
          <script{}>
            {}{}
          </script>
        ]],
        {
          i(1),
          d(2, get_visual),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- DIV
    s({trig = "dd", snippetType="autosnippet"},
      fmt(
        [[
          <div class="{}">
            {}{}
          </div>
        ]],
        {
          i(2),
          d(1, get_visual),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- DIV with ID for practicing Vue
    s({trig = "dii", snippetType="autosnippet"},
      fmt(
        [[
          <div id="{}">
            {}
          </div>
        ]],
        {
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- INPUT ELEMENT
    s({trig = "inn", snippetType="autosnippet"},
      fmt(
        [[
          <input type="{}" id="{}" />
        ]],
        {
          i(1),
          i(2)
        }
      )
    ),
    -- LABEL
    s({trig = "lbl", snippetType="autosnippet"},
      fmt(
        [[
          <label for="{}">
            {}
          </label>
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      )
    ),
    -- BUTTON
    s({trig = "bb", snippetType="autosnippet"},
      fmt(
        [[
          <button type="{}" {}>
            {}
          </button>
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- STRONG ELEMENT
    s({trig = "tbb", snippetType="autosnippet"},
      fmt(
        [[
          <strong>{}</strong>
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
  }
