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

-- from nvim/lua/
local helpers = require("luasnip-helpers")
-- Autosnippet, only for math environments
local asm = helpers.asm
return {
  -- Greek letters
  asm(";a", { t("\\alpha") }),
  asm(";b", { t("\\beta") }),
  asm(";g", { t("\\gamma") }),
  asm(";G", { t("\\Gamma") }),
  asm(";d", { t("\\delta") }),
  asm(";D", { t("\\Delta") }),
  -- Next two are swapped on purpose - always use varepsilon!
  asm(";e", { t("\\varepsilon") }),
  asm(";ve", { t("\\epsilon") }),
  asm(";z", { t("\\zeta") }),
  asm(";t", { t("\\theta") }),
  asm(";vt", { t("\\vartheta") }),
  asm(";T", { t("\\Theta") }),
  asm(";i", { t("\\iota") }),
  asm(";k", { t("\\kappa") }),
  asm(";l", { t("\\lambda") }),
  asm(";L", { t("\\Lambda") }),
  asm(";m", { t("\\mu") }),
  asm(";n", { t("\\nu") }),
  asm(";x", { t("\\xi") }),
  asm(";X", { t("\\Xi") }),
  asm(";pi", { t("\\pi") }),
  asm(";Pi", { t("\\Pi") }),
  asm(";r", { t("\\rho") }),
  asm(";vr", { t("\\varrho") }),
  asm(";s", { t("\\sigma") }),
  asm(";S", { t("\\Sigma") }),
  asm(";t", { t("\\tau") }),
  asm(";u", { t("\\upsilon") }),
  asm(";U", { t("\\Upsilon") }),
  asm(";ph", { t("\\phi") }),
  -- Could be ";vph", but two letters seems nicer
  asm(";vp", { t("\\varphi") }),
  asm(";Ph", { t("\\Phi") }),
  asm(";c", { t("\\chi") }),
  asm(";ps", { t("\\psi") }),
  asm(";Ps", { t("\\Psi") }),
  asm(";o", { t("\\omega") }),
  asm(";O", { t("\\Omega") }),

  asm("ff", fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  asm("tf", fmta("\\tfrac{<>}{<>}", { i(1), i(2) })),

  asm({ trig = "__", wordTrig = false }, fmta("_{<>}", { i(1) })),
  asm({ trig = "^^", wordTrig = false }, fmta("^{<>}", { i(1) })),

  -- Math fonts (in this document, so they only trigger in math environments)
  -- See https://tex.stackexchange.com/questions/58098/what-are-all-the-font-styles-i-can-use-in-math-mode
  asm("rm", fmta("\\mathrm{<>}", { i(1) })),
  asm("bf", fmta("\\boldsymbol{<>}", { i(1) })),
  asm("sf", fmta("\\mathsf{<>}", { i(1) })),
  asm("it", fmta("\\mathit{<>}", { i(1) })),
  asm("tt", fmta("\\mathtt{<>}", { i(1) })),
  -- These two normally not needed, as you would define "\R = \mathbb{R}",
  -- and so on.
  -- asm("bb", fmta("\\mathbb{<>}", { i(1) })),
  asm("cal", fmta("\\mathcal{<>}", { i(1) })),

  -- Delimeters (in math). NEED CORRESPONDING DEFINITIONS IN PREAMBLE
  asm("pp", fmta("\\lr{<>}", { i(1) })),
  asm("ss", fmta("\\lrs{<>}", { i(1) })),
  asm("cc", fmta("\\lrc{<>}", { i(1) })),
  asm("sq", fmta("\\sqrt{<>}", { i(1) })),
}
