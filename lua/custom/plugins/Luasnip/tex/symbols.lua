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
    -- Common symbols
    s({trig="ooo", snippetType="autosnippet"},
      {
        t("\\infty"),
      }
    ),
    s({trig="+-", snippetType="autosnippet"},
      {
        t("\\pm"),
      }
    ),
    s({trig="pm", snippetType="autosnippet"},
    {
      t("\\pm"),
    }),
    s({trig="-+", snippetType="autosnippet"},
    {
      t("\\mp"),
    }),
    s({trig="mp", snippetType="autosnippet"},
    {
      t("\\mp"),
    }),
    s({trig="->", snippetType="autosnippet"},
    {
      t("\\to"),
    }),
    s({trig="!>", snippetType="autosnippet"},
    {
      t("\\mapsto"),
    }),
    s({trig="invs", snippetType="autosnippet"},
    {
      t("^{-1}"),
    }),
    s({trig="and", snippetType="autosnippet"},
    {
      t("\\cap"),
    }),
    s({trig="orr", snippetType="autosnippet"},
    {
      t("\\cup"),
    }),
    s({trig="inn", snippetType="autosnippet"},
    {
      t("\\in"),
    }),
    s({trig="notin", snippetType="autosnippet"},
    {
      t("\\not\\in"),
    }),
    s({trig="eset", snippetType="autosnippet"},
    {
      t("\\emptyset"),
    }),
    s({trig="=>", snippetType="autosnippet"},
    {
      t("\\implies"),
    }),
    s({trig="=<", snippetType="autosnippet"},
    {
      t("\\impliedby"),
    }),
    s({trig="iff", snippetType="autosnippet"},
    {
      t("\\iff"),
    }),
    s({trig="exists", snippetType="autosnippet"},
    {
      t("\\exists"),
    }),

    -- Set notation

    s({trig="NN", snippetType="autosnippet"},
    {
      t("\\mathbb{N}"),
    }),
    s({trig="ZZ", snippetType="autosnippet"},
    {
      t("\\mathbb{Z}"),
    }),
    s({trig="QQ", snippetType="autosnippet"},
    {
      t("\\mathbb{Q}"),
    }),
    s({trig="II1", snippetType="autosnippet"},
    {
      t("\\mathbb{1}"),
    }),
    s({trig="III", snippetType="autosnippet"},
    {
      t("\\mathcal{I}"),
    }),
    s({trig="RR", snippetType="autosnippet"},
    {
      t("\\mathbb{R}"),
    }),
    s({trig="QQ", snippetType="autosnippet"},
    {
      t("\\mathbb{Q}"),
    }),
    s({trig="MnnR", snippetType="autosnippet"},
    {
      t("\\mathcal{M}_{n}(\\mathbb{R})"),
    }),
    s({trig="Mn1R", snippetType="autosnippet"},
    {
      t("\\mathcal{M}_{n,1}(\\mathbb{R})"),
    }),
    s({trig="KK", snippetType="autosnippet"},
    {
      t("\\mathbb{K}"),
    }),
    s({trig="CC", snippetType="autosnippet"},
    {
      t("\\mathbb{C}"),
    }),
    -- Delimiters
    s({trig="norm", snippetType="autosnippet"},
    fmt("\\lvert {} \\rvert",{ i(1) })
    ),
    s({trig="pentiere", snippetType="autosnippet"},
    fmt("\\lfloor {} \\rfloor",{ i(1) })
    ),
    

}