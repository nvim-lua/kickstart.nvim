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
    -- Examples of Greek letter snippets, autotriggered for efficiency
    s({trig="@a", snippetType="autosnippet"},
      {
        t("\\alpha"),
      }
    ),
    s({trig="@b", snippetType="autosnippet"},
      {
        t("\\beta"),
      }
    ),
    s({trig="@g", snippetType="autosnippet"},
      {
        t("\\gamma"),
      }
    ),
    s({trig="@G", snippetType="autosnippet"},
    {
      t("\\Gamma"),
    }
    ),
    s({trig="@g", snippetType="autosnippet"},
      {
        t("\\gamma"),
      }
    ),
    s({trig="@d", snippetType="autosnippet"},
      {
        t("\\delta"),
      }
    ),
    s({trig="@D", snippetType="autosnippet"},
      {
        t("\\Delta"),
      }
    ),
    s({trig="@e", snippetType="autosnippet"},
      {
        t("\\epsilon"),
      }
    ),
    s({trig="@ve", snippetType="autosnippet"},
      {
        t("\\varepsilon"),
      }
    ),
    s({trig="@z", snippetType="autosnippet"},
      {
        t("\\zeta"),
      }
    ),
    s({trig="@h", snippetType="autosnippet"},
      {
        t("\\eta"),
      }
    ),
    s({trig="@th", snippetType="autosnippet"},
      {
        t("\\theta"),
      }
    ),
    s({trig="@Th", snippetType="autosnippet"},
      {
        t("\\Theta"),
      }
    ),
    s({trig="@vth", snippetType="autosnippet"},
      {
        t("\\vartheta"),
      }
    ),
    s({trig="@i", snippetType="autosnippet"},
      {
        t("\\iota"),
      }
    ),
    s({trig="@k", snippetType="autosnippet"},
      {
        t("\\kappa"),
      }
    ),
    s({trig="@g", snippetType="autosnippet"},
      {
        t("\\gamma"),
      }
    ),
    s({trig="@l", snippetType="autosnippet"},
      {
        t("\\lambda"),
      }
    ),
    s({trig="@L", snippetType="autosnippet"},
      {
        t("\\Lambda"),
      }
    ),
    s({trig="@m", snippetType="autosnippet"},
      {
        t("\\mu"),
      }
    ),
    s({trig="@n", snippetType="autosnippet"},
      {
        t("\\nu"),
      }
    ),
    s({trig="@x", snippetType="autosnippet"},
      {
        t("\\xi"),
      }
    ),
    s({trig="@X", snippetType="autosnippet"},
      {
        t("\\Xi"),
      }
    ),
    s({trig="@pi", snippetType="autosnippet"},
      {
        t("\\pi"),
      }
    ),
    s({trig="@Pi", snippetType="autosnippet"},
      {
        t("\\Pi"),
      }
    ),
    s({trig="@r", snippetType="autosnippet"},
      {
        t("\\rho"),
      }
    ),
    s({trig="@s", snippetType="autosnippet"},
      {
        t("\\sigma"),
      }
    ),
    s({trig="@S", snippetType="autosnippet"},
      {
        t("\\Sigma"),
      }
    ),
    s({trig="@t", snippetType="autosnippet"},
      {
        t("\\tau"),
      }
    ),
    s({trig="@ph", snippetType="autosnippet"},
      {
        t("\\phi"),
      }
    ),
    s({trig="@Ph", snippetType="autosnippet"},
      {
        t("\\Phi"),
      }
    ),
    s({trig="@vph", snippetType="autosnippet"},
      {
        t("\\varphi"),
      }
    ),
    s({trig="@ch", snippetType="autosnippet"},
      {
        t("\\chi"),
      }
    ),
    s({trig="@ps", snippetType="autosnippet"},
      {
        t("\\psi"),
      }
    ),
    s({trig="@Ps", snippetType="autosnippet"},
      {
        t("\\Psi"),
      }
    ),
    s({trig="@o", snippetType="autosnippet"},
      {
        t("\\omega"),
      }
    ),
    s({trig="@O", snippetType="autosnippet"},
      {
        t("\\Omega"),
      }
    )
}
