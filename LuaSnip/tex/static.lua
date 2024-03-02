local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Environment/syntax context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end
tex.in_tikz = function()
  local is_inside = vim.fn['vimtex#env#is_inside']("tikzpicture")
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- Return snippet tables
return
  {
    s({trig="q"},
      {
        t("\\quad "),
      }
    ),
    s({trig="qq", snippetType="autosnippet"},
      {
        t("\\qquad "),
      }
    ),
    s({trig="npp", snippetType="autosnippet"},
      {
        t({"\\newpage", ""}),
      },
      {condition = line_begin}
    ),
    s({trig="which", snippetType="autosnippet"},
      {
        t("\\text{ for which } "),
      },
      {condition = tex.in_mathzone}
    ),
    s({trig="all", snippetType="autosnippet"},
      {
        t("\\text{ for all } "),
      },
      {condition = tex.in_mathzone}
    ),
    s({trig="and", snippetType="autosnippet"},
      {
        t("\\quad \\text{and} \\quad"),
      },
      {condition = tex.in_mathzone}
    ),
    s({trig="forall", snippetType="autosnippet"},
      {
        t("\\text{ for all } "),
      },
      {condition = tex.in_mathzone}
    ),
    s({trig = "toc", snippetType="autosnippet"},
      {
        t("\\tableofcontents"),
      },
      { condition = line_begin }
    ),
    s({trig="inff", snippetType="autosnippet"},
      {
        t("\\infty"),
      }
    ),
    s({trig="ii", snippetType="autosnippet"},
      {
        t("\\item "),
      },
      { condition = line_begin }
    ),
    s({trig = "--", snippetType="autosnippet"},
      {t('% --------------------------------------------- %')},
      {condition = line_begin}
    ),
    -- HLINE WITH EXTRA VERTICAL SPACE
    s({trig = "hl"},
      {t('\\hline {\\rule{0pt}{2.5ex}} \\hspace{-7pt}')},
      {condition = line_begin}
    ),
  }
