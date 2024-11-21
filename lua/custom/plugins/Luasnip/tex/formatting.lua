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
local c = ls.choice_node


-- Visual placeholder
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

-- Formatting

-- Text and pages

s({trig = "url", name = "URLs"},
    {
        t("\\url{"), v(1,"url"), t("}")
    }
),

s({trig = "ca", name = "Cancel stroke"},
    {
        t("\\cancel{"), v(1,"text"), t("}")
    }
),

s({trig = "vrb", name = "Short verbatim"},
    {
        t("\\verb="), v(1,"text"), t("=")
    }
),

s({trig = "ltr", name = "Enlarged letter"},
    {
        c(1,
            {
                {
                    t("\\lettrine{"), i(1,"initial"), t("}{"), v(2,"text"), t("}")
                },
                {
                    t("\\lettrine["), i(1,"val-list"), t("]{"), i(2,"initial"), t("}{"), v(3,"text"), t("}")
                }
            }
        )
    }
),

s({trig = "pht", name = "Phantom text"},
    {
		c(1,
		    {
		        {
		            t("\\phantom{"), v(1,"text"), t("}")
		        },
		        {
		            t("\\hphantom{"), v(1,"text"), t("}")
		        },
		        {
		            t("\\vphantom{"), v(1,"text"), t("}")
		        }
		    }
		)
    }
),

s({trig = "foo", name = "Footnote"},
    {
        t("\\footnote{"), v(1,"text"), t("}")
    }
),

s({trig = "mrg", name = "Marginal note"},
    {
        t("\\marginpar{"), v(1,"text"), t("}")
    }
),

s({trig = "npg", name = "New page"},
    {
        t("\\newpage")
    }
),

s({trig = "pp", name = "Paragraph break"},
    {
        t({"",""}),	t("\\bigskip"),	t({"",""}),	t({"",""})
    }
),

s({trig = "fbo", name = "Frame box"},
    {
		c(1,
		    {
		        {
					t("\\fbox{"),
					t({"",""}),	t("    "), d(1,get_visual),
					t({"",""}),	t("}")
		        },
		        {
					t("\\fbox{"), d(1,get_visual), t("}")
		        }
		    }
		)
    }
),

s({trig = "fco", name = "Color frame box"},
    {
		c(1,
		    {
		        {
					t("\\fcolorbox{"), i(1,"border-color"), t("}{"), i(2,"bg-color"), t("}{"),
					t({"",""}),	t("    "), d(3,get_visual),
					t({"",""}),	t("}")
		        },
		        {
					t("\\fcolorbox{"), i(1,"border-color"), t("}{"), i(2,"bg-color"), t("}{"), d(3,get_visual), t("}")
		        }
		    }
		)
    }
),

s({trig = "cen", name = "Centered environment"},
    {
        t("\\begin{center}"),
		t({"",""}),	t("    "), d(1,get_visual),
		t({"",""}),	t("\\end{center}")
    }
),

s({trig = "min", name = "Minpage environment"},
    {
        t("\\begin{minipage}{\\linewidth-3\\fboxsep-3\\fboxrule}"),
		t({"",""}),	t("    "), d(1,get_visual),
		t({"",""}),	t("\\end{minipage}")
    }
),

s({trig = "code", name = "Code chunk"},
    {
       c(1,
           {
               {
                   t("{"),
                   t({"",""}), t("\\renewcommand\\ttdefault{cmtt}"),
                   t({"",""}), t("    \\begin{adjustwidth}{12mm+2mm}{2mm}"),
                   t({"",""}), t("        \\lstinputlisting{"), i(1), t("}"),
                   t({"",""}), t("    \\end{adjustwidth}"),
                   t({"",""}),
                   t({"",""}), t("}")
               },
               {
                   t("{"),
                   t({"",""}), t("\\renewcommand\\ttdefault{cmtt}"),
                   t({"",""}), t("\\begin{adjustwidth}{12mm+2mm}{2mm}"),
                   t({"",""}), t("\\begin{lstlisting}"),
                   t({"",""}), i(1),
                   t({"",""}), t("\\end{lstlisting}"),
                   t({"",""}), t("\\end{adjustwidth}"),
                   t({"",""}), t("}")
               }
           }
       ) 
    }
),

-- Columns

s({trig = "mul", name = "Multicolumns"},
    {
        c(1,
            {
                {
                    t("\\begin{multicols}{"), i(1,"columns"), t("}"),
					t({"",""}), i(2),
					t({"",""}), t("\\end{multicols}")
                },
                {
                    t("\\begin{multicols}{"), i(1,"columns"), t("}["), i(2,"preface"),  t("]"),
					t({"",""}), i(3),
					t({"",""}), t("\\end{multicols}")
                },
                {
                    t("\\begin{multicols}{"), i(1,"columns"), t("}["), i(2,"preface"),  t("]["), i(3,"skip"), t("]"),
					t({"",""}), i(4),
					t({"",""}), t("\\end{multicols}")
                }
            }
        )
    }
),

-- List structures

-- Ordered lists

s({trig = "rff", name = "Item reference format"},
    {
        t(",ref=\\the"), i(1,"<...>"), t(".\\textnormal{"), sn(2,
			c(1,
				{
					{
						i(1,"\\arabic*"), t("}")
					},
					{
						i(1,"\\Roman*"), t("}")
					},
					{
						i(1,"\\roman*"), t("}")
					},
					{
						i(1,"\\Alph*"), t("}")
					},
					{
						i(1,"\\alph*"), t("}")
					}
				}
			)
		)
    }
),

s({trig = "tz", name = "Unnumbered list"},
    {
		t("\\begin{itemize}"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{itemize}")
    }
),

s({trig = "enn", name = "Enumerated list"},
    {
        t("\\begin{enumerate}[label=\\textnormal{(\\arabic*)}]"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{enumerate}")
    }
),

s({trig = "enI", name = "Capital roman enumerated list"},
    {
        t("\\begin{enumerate}[label=\\textnormal{(\\Roman*)}]"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{enumerate}")
    }
),

s({trig = "eni", name = "Lowercase roman enumerated list"},
    {
        t("\\begin{enumerate}[label=\\textnormal{(\\roman*)}]"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{enumerate}")
    }
),

s({trig = "enA", name = "Capital latin enumerated list"},
    {
        t("\\begin{enumerate}[label=\\textnormal{(\\Alph*)}]"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{enumerate}")
    }
),

s({trig = "ena", name = "Lowercase latin enumerated list"},
    {
        t("\\begin{enumerate}[label=\\textnormal{(\\alph*)}]"),
		t({"",""}), t("\\item "), i(1),
		t({"",""}), t("\\end{enumerate}")
    }
),

s({trig = "tm", name = "New item"},
    {
		t({"",""}),
        t("\\item "), i(1)
    }
),

-- Theorem-like environments

s({trig = "oo", name = "New theorem"},
    {
		c(1,
		    {
		        {
					t("\\begin{theorem}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{theorem}")
		        },
		        {
					t("\\begin{theorem}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{theorem}")
		        }
		    }
		)
    }
),

s({trig = "pf", name = "Proof environment"},
    {
		c(1,
		    {
		        {
					t("\\begin{proof}"),
					t({"",""}), i(1),
					t({"",""}), t("\\end{proof}")
		        },
		        {
					t("\\begin{proof}["), i(1,"name"), t("]"),
					t({"",""}), i(2),
					t({"",""}), t("\\end{proof}")
		        }
		    }
		)
    }
),

s({trig = "ps", name = "New proposition"},
    {
		c(1,
		    {
		        {
					t("\\begin{proposition}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{proposition}")
		        },
		        {
					t("\\begin{proposition}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{proposition}")
		        }
		    }
		)
    }
),

s({trig = "cc", name = "New corollary"},
    {
		c(1,
		    {
		        {
					t("\\begin{corollary}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{corollary}")
		        },
		        {
					t("\\begin{corollary}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{corollary}")
		        }
		    }
		)
    }
),

s({trig = "ll", name = "New lemma"},
    {
		c(1,
		    {
		        {
					t("\\begin{lemma}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{lemma}")
		        },
		        {
					t("\\begin{lemma}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{lemma}")
		        }
		    }
		)
    }
),

s({trig = "dd", name = "New definition"},
    {
		c(1,
		    {
		        {
					t("\\begin{definition}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{definition}")
		        },
		        {
					t("\\begin{definition}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{definition}")
		        }
		    }
		)
    }
),

s({trig = "re", name = "New remark"},
    {
		c(1,
		    {
		        {
					t("\\begin{remark}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{remark}")
		        },
		        {
					t("\\begin{remark}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{remark}")
		        }
		    }
		)
    }
),

s({trig = "ex", name = "New exercise"},
    {
		c(1,
		    {
		        {
					t("\\begin{exercise}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{exercise}")
		        },
		        {
					t("\\begin{exercise}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{exercise}")
		        }
		    }
		)
    }
),

s({trig = "ee", name = "New example"},
    {
		c(1,
		    {
		        {
					t("\\begin{example}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{example}")
		        },
		        {
					t("\\begin{example}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{example}")
		        }
		    }
		)
    }
),

s({trig = "pn", name = "New principle"},
    {
		c(1,
		    {
		        {
					t("\\begin{principle}"),
					t({"",""}), d(1,get_visual),
					t({"",""}), t("\\end{principle}")
		        },
		        {
					t("\\begin{principle}["), i(1,"name"), t("]"),
					t({"",""}), d(2,get_visual),
					t({"",""}), t("\\end{principle}")
		        }
		    }
		)
    }
),

}
