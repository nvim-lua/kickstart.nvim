local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- Fenced block of code
    s({trig="cc", snippetType = "autosnippet"},
      fmta(
        [[
        ```<>
        <>
        ```
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- HTML CODE BLOCK
    s({trig="html"},
      fmta(
        [[
        ```html
        <>
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PHP CODE BLOCK
    s({trig="phpp", snippetType="autosnippet"},
      fmt(
        [[
        ```php
        <?php
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PYTHON CODE BLOCK
    s({trig="pyy", snippetType="autosnippet"},
      fmt(
        [[
        ```python
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- BEANCOUNT CODE BLOCK
    s({trig="bc"},
      fmt(
        [[
        ```beancount
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- BASH CODE BLOCK
    s({trig="shh", snippetType="autosnippet"},
      fmt(
        [[
        ```bash
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- SQL CODE BLOCK
    s({trig="qq", snippetType="autosnippet"},
      fmt(
        [[
        ```sql
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- JAVASCRIPT CODE BLOCK
    s({trig="jss", snippetType="autosnippet"},
      fmt(
        [[
        ```javascript
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- VUE CODE BLOCK
    s({trig="vuu", snippetType="autosnippet"},
      fmt(
        [[
        ```vue
        {}<script setup>
        {}
        </script>
        ```
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      ),
      {condition = line_begin}
    ),
  }

