local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- GENERIC ENVIRONMENT
    s({trig="new", snippetType="autosnippet"},
      fmta(
        [[
        \begin{<>}
            <>
        \end{<>}
      ]],
        {
          i(1),
          d(2, get_visual),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
    -- ENVIRONMENT WITH ONE EXTRA ARGUMENT
    s({trig="n2", snippetType="autosnippet"},
      fmta(
        [[
        \begin{<>}{<>}
            <>
        \end{<>}
      ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
          rep(1),
        }
      ),
      { condition = line_begin }
    ),
    -- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
    s({trig="n3", snippetType="autosnippet"},
      fmta(
        [[
        \begin{<>}{<>}{<>}
            <>
        \end{<>}
      ]],
        {
          i(1),
          i(2),
          i(3),
          d(4, get_visual),
          rep(1),
        }
      ),
      { condition = line_begin }
    ),
    -- TOPIC ENVIRONMENT (my custom tcbtheorem environment)
    s({trig="nt", snippetType="autosnippet"},
      fmta(
        [[
        \begin{topic}{<>}{<>}
            <>
        \end{topic}
      ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      { condition = line_begin }
    ),
    -- EQUATION
    s({trig="nn", snippetType="autosnippet"},
      fmta(
        [[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
        {
          i(1),
        }
      ),
      { condition = line_begin }
    ),
    -- SPLIT EQUATION
    s({trig="ss", snippetType="autosnippet"},
      fmta(
        [[
        \begin{equation*}
            \begin{split}
                <>
            \end{split}
        \end{equation*}
      ]],
        {
          d(1, get_visual),
        }
      ),
      { condition = line_begin }
    ),
    -- ALIGN
    s({trig="all", snippetType="autosnippet"},
      fmta(
        [[
        \begin{align*}
            <>
        \end{align*}
      ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- ITEMIZE
    s({trig="itt", snippetType="autosnippet"},
      fmta(
        [[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
        {
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- ENUMERATE
    s({trig="enn", snippetType="autosnippet"},
      fmta(
        [[
        \begin{enumerate}

            \item <>

        \end{enumerate}
      ]],
        {
          i(0),
        }
      )
    ),
    -- INLINE MATH
    s({trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>$<>$",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- INLINE MATH ON NEW LINE
    s({trig = "^mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "$<>$",
{
          i(1),
        })),
    -- FIGURE
    s({trig = "fig"},
      fmta(
        [[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4),
        }
      ),
      { condition = line_begin }
    ),
  }
