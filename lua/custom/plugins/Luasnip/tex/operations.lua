local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep



return {
  s({ trig = "BigProd",snippetType="autosnippet" },
    fmta('\\prod_{<>}^{<>} <>', {
      i(1, "n=1"),
      i(2, "\\infty"),
      i(0),}
    )),
    s(
      { trig = "__", snippetType="autosnippet" },
      fmta("_{<>}", { i(1) })
    ),
    s({ trig = "!=", snippetType = "autosnippet" }, {t("\\neq")}),

    s({ trig = "==", snippetType = "autosnippet" }, {t("&= \\\\")}),
  
    s({ trig = "~=", snippetType = "autosnippet" }, {t("\\approx ")}),
  
    s({ trig = "~~", snippetType = "autosnippet" }, {t("\\sim ")}),
  
    s({ trig = "->", snippetType = "autosnippet" }, {t("\\to ")}),
  
    s({ trig = "<->", snippetType = "autosnippet" }, {t("\\leftrightarrow")}),
  
    s({ trig = "!>", snippetType = "autosnippet" }, {t("\\mapsto ")}),
  
    s({ trig = ">>", snippetType = "autosnippet" }, {t("\\gg")}),
  
    s({ trig = "<<", snippetType = "autosnippet" }, {t("\\ll")}),

    s({ trig = "cc", snippetType = "autosnippet" }, {t("\\subset ")}),

    s({ trig = "notin", snippetType = "autosnippet" }, {t("\\not\\in ")}),
    
    s({ trig = "inn", snippetType = "autosnippet" }, {t("\\in ")}),

    s({ trig = "Nn", snippetType = "autosnippet" }, {t("\\cap ")}),

    s({ trig = "UU", snippetType = "autosnippet" }, {t("\\cup ")}),
    --- Debugging additional snippets
    s(
    { trig = "uuu", snippetType = "autosnippet" },
    fmta("\\bigcup_{<> \\in <>} <>", {
      i(1, "i"),
      i(2, "I"),
      i(0),
    })
  ),
  s({trig="rond", snippetType="autosnippet"},
    {
      t("\\circ"),
  }),
  s({trig="Brond", snippetType="autosnippet"},
    {
      t("\\bigcircs"),
  }),
  s(
    { trig = "Pscal", snippetType = "autosnippet" },
    fmta("\\bigcup_{<> \\in <>} <>", {
      i(1, "i"),
      i(2, "I"),
      i(0),
    })
  ),
  s({trig="nabl", snippetType="autosnippet"},
    {
      t("\\nabla"),
  }),
  s({trig="partial", snippetType="autosnippet"},
  {
    t("\\partial"),
  }),
  s({trig=";comp", snippetType="autosnippet"},
  {
    t("^{c}")
  }),
  s({trig="//",snippetType="autosnippet"},
    fmta("\\frac{<>}{<>}<>", {
      i(1,"a"),
      i(2,"b"),
      i(0," ")
    })),
  }
