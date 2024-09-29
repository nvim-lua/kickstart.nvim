local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require('luasnip.extras.fmt').fmt

return {

  s(
    'cww',
    fmt('Console.WriteLine({});{}', {
      i(1, ''),
      i(0),
    })
  ),

  s(
    'cw',
    fmt('Console.Write({});{}', {
      i(1, ''),
      i(0),
    })
  ),

  s(
    'do',
    fmt(
      [[
do
{{
{}}} while ({});
{}]],
      {
        i(2),
        i(1),
        i(0),
      }
    )
  ),

  s(
    'while',
    fmt(
      [[
while ({})
{{
{}}}
{}]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    'fo',
    fmt(
      [[
for (int {} = 0; {} < {}; {}++)
{{
{}}}
{}]],
      {
        i(2, 'i'),
        f(function(args)
          return args[1][1]
        end, { 2 }),
        i(1, '1'),
        f(function(args)
          return args[1][1]
        end, { 2 }),
        i(3),
        i(0),
      }
    )
  ),

  s(
    'forr',
    fmt(
      [[
for (int {} = {} - 1; {} >= 0; {}--)
{{
{}}}
{}]],
      {
        i(2, 'i'),
        i(1, 'length'),
        f(function(args)
          return args[1][1]
        end, { 2 }),
        f(function(args)
          return args[1][1]
        end, { 2 }),
        i(3),
        i(0),
      }
    )
  ),

  s('cc', t 'Console.Clear();'),

  s('crk', t 'Console.ReadKey(true);'),

  s('crl', t 'Console.ReadLine();'),

  s(
    'foreach',
    fmt(
      [[
foreach ({})
{{
{}}}{}]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    'cla',
    fmt(
      [[
class {}
{{
{}}}
  ]],
      {
        i(1, 'ClassName'),
        i(0),
      }
    )
  ),

  s(
    'inter',
    fmt(
      [[
interface {}
{{
{}}}
  ]],
      {
        i(1, 'IInterfaceName'),
        i(0),
      }
    )
  ),

  s(
    'enu',
    fmt(
      [[
enum {}
{{
{}}}
  ]],
      {
        i(1, 'EnumName'),
        i(0),
      }
    )
  ),

  s('comment', {
    t { '/*', '' },
    i(1),
    t { '', '*/' },
  }),
}
