local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
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

-- Document preamble

s({trig = "doc", name = "Document class"},
    {
		c(1,
		    {
		        {
        			t("\\documentclass{"), i(1,"document-class"), t("}")
		        },
		        {
        			t("\\documentclass["), i(1,"class-options"), t("]{"), i(2,"document-class"), t("}")
		        }
		    }
		)
    }
),

s({trig = "pk", name = "Use package"},
    {
        c(1,
            {
                {
                    t("\\usepackage{"), i(1,"package-name"), t("}")
                },
                {
                    t("\\usepackage["), i(1,"package-options"), t("]{"), i(2,"package-name"), t("}")
                }
            }
        )
    }
),

s({trig = "tl", name = "Title"},
    {
        t("\\title{"), i(1,"..."), t("}")
    }
),

s({trig = "dat", name = "Date"},
    {
        t("\\date{"), i(1,"..."), t("}")
    }
),

s({trig = "aut", name = "Author"},
    {
        t("\\author{"), i(1,"..."), t("}")
    }
),

s({trig = "td", name = "Today's date"},
    {
		t("\\today")
    }
),

s({trig = "bd", name = "Begin document"},
    {
        t("\\begin{document}"),
		t({"",""}),
		t({"",""}), i(1),
		t({"",""}),
		t({"",""}), t("\\end{document}")
    }
),

-- Sectioning

s({trig = "scn", name = "Section"},
    {
        c(1,
            {
                {
                    t("\\section{"), v(1,"title"), t("}")
                },
                {
                    t("\\section*{"), v(1,"title"), t("}")
                },
				{
					t("\\section["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "sbn", name = "Subection"},
    {
        c(1,
            {
                {
                    t("\\subsection{"), v(1,"title"), t("}")
                },
                {
                    t("\\subsection*{"), v(1,"title"), t("}")
                },
				{
					t("\\subsection["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "ssn", name = "Subsubection"},
    {
        c(1,
            {
                {
                    t("\\subsubsection{"), v(1,"title"), t("}")
                },
                {
                    t("\\subsubsection*{"), v(1,"title"), t("}")
                },
				{
					t("\\subsubsection["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "chr", name = "Chapter"},
    {
        c(1,
            {
                {
                    t("\\chapter{"), v(1,"title"), t("}")
                },
                {
                    t("\\chapter*{"), v(1,"title"), t("}")
                },
				{
					t("\\chapter["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "prt", name = "Part"},
    {
        c(1,
            {
                {
                    t("\\part{"), i(1,"title"), t("}")
                },
                {
                    t("\\part*{"), i(1,"title"), t("}")
                },
				{
					t("\\part["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "pr", name = "Paragraph"},
    {
        c(1,
            {
                {
                    t("\\paragraph{"), i(1,"title"), t("}")
                },
                {
                    t("\\paragraph*{"), i(1,"title"), t("}")
                },
				{
					t("\\paragraph["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "sbp", name = "Subaragraph"},
    {
        c(1,
            {
                {
                    t("\\subparagraph{"), i(1,"title"), t("}")
                },
                {
                    t("\\subparagraph*{"), i(1,"title"), t("}")
                },
				{
					t("\\subparagraph["), i(1,"toc-entry"), t("]{"), v(2,"title"), t("}")
				}
            }
        )
    }
),

s({trig = "phs", name = "Hyperref jump to correct page"},
    {
        t("\\phantomsection")
    }
),

s({trig = "add", name = "Add entry to list"},
    {
        t("\\addcontentsline{"), i(1,"file"), t("}{"), i(2,"sec-unit"), t("}{"), i(3,"list-entry"), t("}")
    }
),

s({trig = "mkb", name = "Headers in twoside mode"},
    {
        t("\\markboth{"), i(1,"left"), t("}{"), i(2,"right"), t("}")
    }
),

s({trig = "mkt", name = "Maketitle"},
    {
        t("\\maketitle")
    }
),

s({trig = "toc", name = "Table of contents"},
    {
        t("\\tableofcontents")
    }
),

s({trig = "lot", name = "List of tables"},
    {
        t("\\listoftables")
    }
),

s({trig = "lof", name = "List of figures"},
    {
        t("\\listoffigures")
    }
),

s({trig = "mki", name = "Makeindex"},
    {
        t("\\makeindex")
    }
),

s({trig = "pix", name = "Print index"},
    {
        t("\\printindex")
    }
),

s({trig = "pdf", name = "PDF bookmark"},
    {
        t("\\texorpdfstring{"), v(1,"tex"), t("}{"), i(2,"bookmark"), t("}")
    }
),

s({trig = "lec", name = "Lecture section"},
    {
        t("%%% "), v(1,"title"),
        t({"",""}), t("\\seclecture{"), rep(1), t("}{"), i(2,"date"), t("}")
    }
),

s({trig = "les", name = "Lecture subsection"},
    {
        t("%%% "), v(1,"title"),
        t({"",""}), t("\\sublecture{"), rep(1), t("}{"), i(2,"date"), t("}")
    }
),

s({trig = "date", name = "Print current date"},
    {
		f(function() return os.date("%a %d %b %y") end)
    }
),

s({trig = "tim", name = "Margin paragraph timestamp"},
    {
		t("\\marginpar{\\footnotesize\\textsf{\\mbox{"), i(1,"date"), t("}}}")
    }
),

-- Cross-references

-- Labels

s({trig = "lge", name = "Generic label"},
    {
        t("\\label{"), i(1,"key"), t("}")
    }
),

s({trig = "lsn", name = "Label section"},
    {
        t("\\label{sec:"), i(1,"key"), t("}")
    }
),

s({trig = "lsb", name = "Label subsection"},
    {
        t("\\label{sub:"), i(1,"key"), t("}")
    }
),

s({trig = "lss", name = "Label subsubsection"},
    {
        t("\\label{ssub:"), i(1,"key"), t("}")
    }
),

s({trig = "lch", name = "Label chapter"},
    {
        t("\\label{ch:"), i(1,"key"), t("}")
    }
),

s({trig = "lpa", name = "Label paragraph"},
    {
        t("\\label{par:"), i(1,"key"), t("}")
    }
),

s({trig = "lsp", name = "Label subparagraph"},
    {
        t("\\label{subpar:"), i(1,"key"), t("}")
    }
),

s({trig = "lbe", name = "Label equation"},
    {
        t("\\label{eq:"), i(1,"key"), t("}")
    }
),

s({trig = "lbt", name = "Label theorem"},
    {
        t("\\label{thm:"), i(1,"key"), t("}")
    }
),

s({trig = "lps", name = "Label proposition"},
    {
        t("\\label{prop:"), i(1,"key"), t("}")
    }
),

s({trig = "lle", name = "Label lemma"},
    {
        t("\\label{lem:"), i(1,"key"), t("}")
    }
),

s({trig = "lco", name = "Label corollary"},
    {
        t("\\label{cor:"), i(1,"key"), t("}")
    }
),

s({trig = "lde", name = "Label definition"},
    {
        t("\\label{def:"), i(1,"key"), t("}")
    }
),

s({trig = "lre", name = "Label remark"},
    {
        t("\\label{rem:"), i(1,"key"), t("}")
    }
),

s({trig = "lex", name = "Label exercise"},
    {
        t("\\label{ex:"), i(1,"key"), t("}")
    }
),

s({trig = "leg", name = "Label example"},
    {
        t("\\label{eg:"), i(1,"key"), t("}")
    }
),

s({trig = "lpn", name = "Label principle"},
    {
        t("\\label{princ:"), i(1,"key"), t("}")
    }
),

s({trig = "lbi", name = "Label item"},
    {
        t("\\label{it:"), i(1,"key"), t("}")
    }
),

s({trig = "lfg", name = "Label figure"},
    {
        t("\\label{fig:"), i(1,"key"), t("}")
    }
),

s({trig = "lta", name = "Label table"},
    {
        t("\\label{tbl:"), i(1,"key"), t("}")
    }
),

-- Reference commands

s({trig = "rge", name = "Generic cross-reference"},
    {
		c(1,
		    {
		        {
        			t("\\ref{"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rsn", name = "Reference section"},
    {
		c(1,
		    {
		        {
        			t("\\ref{sec:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{sec:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{sec:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rsb", name = "Reference subsection"},
    {
		c(1,
		    {
		        {
        			t("\\ref{sub:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{sub:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{sub:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rss", name = "Reference subsubsection"},
    {
		c(1,
		    {
		        {
        			t("\\ref{ssub:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{ssub:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{ssub:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rch", name = "Reference chapter"},
    {
		c(1,
		    {
		        {
        			t("\\ref{ch:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{ch:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{ch:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rpa", name = "Reference paragraph"},
    {
		c(1,
		    {
		        {
        			t("\\ref{par:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{par:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{par:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rsp", name = "Reference subparagraph"},
    {
		c(1,
		    {
		        {
        			t("\\ref{subpar:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{subpar:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{subpar:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rfe", name = "Reference equation"},
    {
		c(1,
		    {
		        {
        			t("\\eqref{eq:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{eq:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{eq:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rft", name = "Reference theorem"},
    {
		c(1,
		    {
		        {
        			t("\\ref{thm:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{thm:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{thm:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rps", name = "Reference proposition"},
    {
		c(1,
		    {
		        {
        			t("\\ref{prop:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{prop:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{prop:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rle", name = "Reference lemma"},
    {
		c(1,
		    {
		        {
        			t("\\ref{lem:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{lem:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{lem:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rco", name = "Reference corollary"},
    {
		c(1,
		    {
		        {
        			t("\\ref{cor:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{cor:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{cor:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rde", name = "Reference definition"},
    {
		c(1,
		    {
		        {
        			t("\\ref{def:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{def:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{def:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rre", name = "Reference remark"},
    {
		c(1,
		    {
		        {
        			t("\\ref{rem:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{rem:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{rem:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rex", name = "Reference exercise"},
    {
		c(1,
		    {
		        {
        			t("\\ref{ex:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{ex:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{ex:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "reg", name = "Reference example"},
    {
		c(1,
		    {
		        {
        			t("\\ref{eg:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{eg:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{eg:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rpn", name = "Reference principle"},
    {
		c(1,
		    {
		        {
        			t("\\ref{princ:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{princ:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{princ:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rfi", name = "Reference item"},
    {
		c(1,
		    {
		        {
        			t("\\ref{it:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{it:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{it:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rfg", name = "Reference figure"},
    {
		c(1,
		    {
		        {
        			t("\\ref{fig:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{fig:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{fig:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

s({trig = "rta", name = "Reference table"},
    {
		c(1,
		    {
		        {
        			t("\\ref{tbl:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\cref{tbl:"), i(1,"key"), t("}")
		        },
		        {
        			t("\\Cref{tbl:"), i(1,"key"), t("}")
		        }
		    }
		)
    }
),

-- Page reference commands

s({trig = "pge", name = "Generic page reference"},
    {
        t("\\pageref{"), i(1,"key"), t("}")
    }
),

s({trig = "psn", name = "Page of section"},
    {
        t("\\pageref{sec:"), i(1,"key"), t("}")
    }
),

s({trig = "psb", name = "Page of subsection"},
    {
        t("\\pageref{sub:"), i(1,"key"), t("}")
    }
),

s({trig = "pss", name = "Page of subsubsection"},
    {
        t("\\pageref{ssub:"), i(1,"key"), t("}")
    }
),

s({trig = "pch", name = "Page of chapter"},
    {
        t("\\pageref{ch:"), i(1,"key"), t("}")
    }
),

s({trig = "ppa", name = "Page of paragraph"},
    {
        t("\\pageref{par:"), i(1,"key"), t("}")
    }
),

s({trig = "psp", name = "Page of subparagraph"},
    {
        t("\\pageref{subpar:"), i(1,"key"), t("}")
    }
),

s({trig = "peq", name = "Page of equation"},
    {
        t("\\eqref{eq:"), i(1,"key"), t("}")
    }
),

s({trig = "pgt", name = "Page of theorem"},
    {
        t("\\pageref{thm:"), i(1,"key"), t("}")
    }
),

s({trig = "pps", name = "Page of proposition"},
    {
        t("\\pageref{prop:"), i(1,"key"), t("}")
    }
),

s({trig = "ple", name = "Page of lemma"},
    {
        t("\\pageref{lem:"), i(1,"key"), t("}")
    }
),

s({trig = "pco", name = "Page of corollary"},
    {
        t("\\pageref{cor:"), i(1,"key"), t("}")
    }
),

s({trig = "pde", name = "Page of definition"},
    {
        t("\\pageref{def:"), i(1,"key"), t("}")
    }
),

s({trig = "pre", name = "Page of remark"},
    {
        t("\\pageref{rem:"), i(1,"key"), t("}")
    }
),

s({trig = "pex", name = "Page of exercise"},
    {
        t("\\pageref{ex:"), i(1,"key"), t("}")
    }
),

s({trig = "peg", name = "Page of example"},
    {
        t("\\pageref{eg:"), i(1,"key"), t("}")
    }
),

s({trig = "ppn", name = "Page of principle"},
    {
        t("\\pageref{princ:"), i(1,"key"), t("}")
    }
),

s({trig = "pgi", name = "Page of item"},
    {
        t("\\pageref{it:"), i(1,"key"), t("}")
    }
),

s({trig = "pfg", name = "Page of figure"},
    {
        t("\\pageref{fig:"), i(1,"key"), t("}")
    }
),

s({trig = "pta", name = "Page of table"},
    {
        t("\\pageref{tbl:"), i(1,"key"), t("}")
    }
),

}
