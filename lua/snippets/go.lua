local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {

  s('reverseString!', {
    t {
      'func reverseString(s string) string {',
      '\trunes := []rune(s)',
      '\tfor i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {',
      '\t\trunes[i], runes[j] = runes[j], runes[i]',
      '\t}',
      '\treturn string(runes)',
      '}',
    },
  }),
  -- new snipp
}
