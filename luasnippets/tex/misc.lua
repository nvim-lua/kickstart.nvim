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
-- local in_mathzone = function()
--   return vim.fn["vimtex#syntax#in_mathzone"]() == 1
-- end
-- AutoSnippet function "as":
local function as(trigger, nodes, opts)
  -- Only trigger commands in mathzones
  opts = opts or {}
  -- Add snippetType = "autosnippet" to the first parameter
  if type(trigger) == "table" then
    trigger.snippetType = "autosnippet"
  else
    trigger = { trig = trigger, snippetType = "autosnippet" }
  end
  return s(trigger, nodes, opts)
end

return {
  as({ trig = "{{", wordTrig = false }, fmta("{<>}", { i(1) })),
  as({ trig = "[[", wordTrig = false }, fmta("[<>]", { i(1) })),
  as({ trig = "((", wordTrig = false }, fmta("(<>)", { i(1) })),
  as({ trig = "{}", wordTrig = false }, fmta("{<>}", { i(1) })),
  as({ trig = "[]", wordTrig = false }, fmta("[<>]", { i(1) })),
  as({ trig = "()", wordTrig = false }, fmta("(<>)", { i(1) })),
  as("mm", fmta("$<>$", { i(1) })),
  as("$$", fmta("$<>$", { i(1) })),
}
