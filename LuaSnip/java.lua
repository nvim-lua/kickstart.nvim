local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- main function
    s({trig = "mm", snippetType="autosnippet"},
      fmta(
        [[
          public static void main(String[] args) {
              <>
          }
        ]],
        { i(0) }
      ),
      {condition = line_begin}
    ),
    -- CURLY BRACES
    s({trig = "df", snippetType="autosnippet", priority=1000},
      fmta(
        [[
        {
            <>
        }
        ]],
        { d(1, get_visual) }
      )
    ),
    -- class
    s({trig = "pcc", snippetType="autosnippet"},
      fmta(
        [[
          public class <>
          {
              <>
          }
        ]],
        { i(1), i(0) }
      ),
      {condition = line_begin}
    ),
    -- constructor
    s({trig = "puu", snippetType="autosnippet"},
      fmta(
        [[
          public <>(<>) {
              <>
          }
        ]],
        { i(1), i(2), i(3) }
      ),
      {condition = line_begin}
    ),
    -- New object
    s({trig = "nn", snippetType="autosnippet"},
      fmta(
        [[
          <> <> = new <>(<>);
        ]],
        { i(1), i(2), rep(1), i(3) }
      ),
      {condition = line_begin}
    ),
    -- public function
    s({trig = "pff", snippetType="autosnippet"},
      fmta(
        [[
          public <> <>(<>) {
              <>
          }
        ]],
        { i(1), i(2), i(3), i(4) }
      ),
      {condition = line_begin}
    ),
    -- public static function
    s({trig = "psf", snippetType="autosnippet"},
      fmta(
        [[
          public static <> <>(<>) {
              <>
          }
        ]],
        { i(1), i(2), i(3), i(4) }
      ),
      {condition = line_begin}
    ),
    -- private function
    s({trig = "pvv", snippetType="autosnippet"},
      fmta(
        [[
          private <> <>(<>) {
              <>
          }
        ]],
        { i(1), i(2), i(3), i(4) }
      ),
      {condition = line_begin}
    ),
    -- if statement
    s({trig = "iff", snippetType="autosnippet"},
      fmta(
        [[
          if (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- for loop with int i counter and optional statement braces
    s({trig = "fii", snippetType="autosnippet"},
      fmta(
        [[
          for (int i = 0; i <>; i++) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- for loop with int j counter and optional statement braces
    s({trig = "fjj", snippetType="autosnippet"},
      fmta(
        [[
          for (int j = 0; j <>; j++) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- for loop with blank arguments
    s({trig = "frr", snippetType="autosnippet"},
      fmta(
        [[
          for (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- while loop
    s({trig = "wll", snippetType="autosnippet"},
      fmta(
        [[
          while (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- block comment
    s({trig = "cc", snippetType="autosnippet"},
      fmta(
        [[
          /**
          * <>
          */
        ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),
    -- println using algs4 StdOut
    s({trig = "pp", snippetType="autosnippet"},
      fmta(
        [[
          StdOut.println(<>);
        ]],
        { d(1, get_visual) }
      ),
      {condition = line_begin}
    ),
    -- Integer.parseInt()
    s({trig = "ipi", snippetType="autosnippet"},
      fmta(
        [[
          Integer.parseInt(<>)
        ]],
        { d(1, get_visual) }
      )
    ),
    -- Double.parseDouble()
    s({trig = "dpd", snippetType="autosnippet"},
      fmta(
        [[
          Double.parseDouble(<>)
        ]],
        { d(1, get_visual) }
      )
    ),
    -- Import from algs4
    s({trig = ";ii", snippetType="autosnippet"},
      fmta(
        [[
          import edu.princeton.cs.algs4.<>;
        ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),
    -- Import StdIn from algs4
    s({trig = ";in", snippetType="autosnippet"},
      {t("import edu.princeton.cs.algs4.StdIn;")},
      {condition = line_begin}
    ),
    -- Import StdOut from algs4
    s({trig = ";io", snippetType="autosnippet"},
      {t("import edu.princeton.cs.algs4.StdOut;")},
      {condition = line_begin}
    ),
    -- array length
    s({trig = ";l", wordTrig=false, snippetType="autosnippet"},
      fmta(
        [[
          .length
        ]],
        {}
      )
    ),
  }
