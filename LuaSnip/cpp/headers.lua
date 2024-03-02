local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- GENERIC HEADER INCLUDE
  s({trig = "hh", snippetType="autosnippet"},
    fmt(
      [[#include <{}>]],
      { 
        d(1, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- STDIO HEADER
  s({trig = "hio", snippetType="autosnippet"},
    { t('#include <iostream>') },
    {condition = line_begin}
  ),
  -- MATH HEADER
  s({trig = "hmath", snippetType="autosnippet"},
    { t('#include <cmath>') },
    {condition = line_begin}
  ),
  -- STRING HEADER
  s({trig = "hstr", snippetType="autosnippet"},
    { t('#include <string>') },
    {condition = line_begin}
  ),
}
