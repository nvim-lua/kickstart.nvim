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


-- Visual placeholder
--
-- taken from https://ejmastnak.com/

local get_visual = function(args, parent, default_text)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1,parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1,default_text))
  end
end

local function v(pos, default_text)
  return d(pos, function(args, parent) return get_visual(args, parent, default_text) end)
end

return {

-- Fonts

-- Standard size-changing commands

s({trig = "tny", name = "Tiny font size"},
    {
        t("\\tiny")
    }
),

s({trig = "scr", name = "Scriptize font size"},
    {
        t("\\scriptsize")
    }
),

s({trig = "fot", name = "Footnote size"},
    {
        t("\\footnotesize")
    }
),

s({trig = "sma", name = "Small font size"},
    {
        t("\\small")
    }
),

s({trig = "nor", name = "Normalsize font"},
    {
        t("\\normalsize")
    }
),

s({trig = "lar", name = "Large font size"},
    {
        c(1,
            {
                {
                    i(1,"\\large")
                },
                {
                    i(1,"\\Large")
                },
                {
                    i(1,"\\LARGE")
                }
            }
        )
    }
),

s({trig = "hug", name = "Huge font size"},
    {
        c(1,
            {
                {
                    i(1,"\\huge")
                },
                {
                    i(1,"\\Huge")
                }
            }
        )
    }
),

-- Standard font-changing commands and declarations

s({trig = "rm", name = "Roman family"},
    {
        c(1,
            {
                {
                    t("\\textrm{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{rmfamily}"), v(1,"..."), t("\\end{rmfamily}")
                },
                {
					i(1,"\\rmfamily")
                }
            }
        )
    }
),

s({trig = "sf", name = "Sans serif family"},
    {
        c(1,
            {
                {
                    t("\\textsf{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{sffamily}"), v(1,"..."), t("\\end{sffamily}")
                },
                {
					i(1,"\\sffamily")
                }
            }
        )
    }
),

s({trig = "tt", name = "Typewriter family"},
    {
        c(1,
            {
                {
                    t("\\texttt{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{ttfamily}"), v(1,"..."), t("\\end{ttfamily}")
                },
                {
					i(1,"\\ttfamily")
                }
            }
        )
    }
),

s({trig = "bf", name = "Bold series"},
    {
        c(1,
            {
                {
                    t("\\textbf{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{bfseries}"), v(1,"..."), t("\\end{bfseries}")
                },
                {
					i(1,"\\bfseries")
                }
            }
        )
    }
),

s({trig = "it", name = "Italic shape"},
    {
        c(1,
            {
                {
                    t("\\textit{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{itshape}"), v(1,"..."), t("\\end{itshape}")
                },
                {
					i(1,"\\itshape")
                }
            }
        )
    }
),

s({trig = "sc", name = "Small caps shape"},
    {
        c(1,
            {
                {
                    t("\\textsc{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{scshape}"), v(1,"..."), t("\\end{scshape}")
                },
                {
					i(1,"\\scshape")
                }
            }
        )
    }
),

s({trig = "em", name = "Emphasized text"},
    {
        c(1,
            {
                {
                    t("\\emph{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{em}"), v(1,"..."), t("\\end{em}")
                },
                {
					i(1,"\\em")
                }
            }
        )
    }
),

s({trig = "tn", name = "Main font"},
    {
        c(1,
            {
                {
                    t("\\textnormal{"), v(1,"text"), t("}")
                },
                {
                    t("\\begin{normalfont}"), v(1,"..."), t("\\end{normalfont}")
                },
                {
					i(1,"\\normalfont")
                }
            }
        )
    }
),

}
