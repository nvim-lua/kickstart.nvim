-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
return {
  -- Snippet snippets
  s(
    { trig = "asm", descr = "Autosnippet in math environment" },
    fmta(
      [[asm("<>", fmta("<>", { <> })),]],
      { i(1, "trig"), i(2), i(3, "i(1)") }
    )
  ),
  s(
    { trig = "as", descr = "Autosnippet (own defined function)" },
    fmta(
      [[as("<>", fmta("<>", { <> })),]],
      { i(1, "trig"), i(2), i(3, "i(1)") }
    )
  ),
  s(
    { trig = "ast", descr = "Autosnippet in text mode" },
    fmta(
      [[ast("<>", fmta("<>", { <> })),]],
      { i(1, "trig"), i(2), i(3, "i(1)") }
    )
  ),
}
