-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep

-- from nvim/lua/
local helpers = require("luasnip-helpers")
local as = helpers.as
local ast = helpers.ast
return {
  -- Fonts
  ast("ttt", fmta("\\texttt{<>}", { i(1) })),
  -- asm("rm", fmta("\\mathrm{<>}", { i(1) })),
  ast("tbf", fmta("\\textbf{<>}", { i(1) })),
  ast("tsf", fmta("\\textsf{<>}", { i(1) })),
  ast("tit", fmta("\\textit{<>}", { i(1) })),
  -- Idk, maybe emph can be used in mathmode?
  ast("emp", fmta("\\emph{<>}", { i(1) })),
  -- These two normally not needed, as you would define "\R = \mathbb{R}",
  -- and so on.
  -- as("bb", fmta("\\mathbb{<>}", { i(1) })),
  -- as("cal", fmta("\\mathcal{<>}", { i(1) })),
}
