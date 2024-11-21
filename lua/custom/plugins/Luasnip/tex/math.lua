local ls = require("luasnip")
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node

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
-- Auxiliary functions

-- Math zone context
-- taken from https://ejmastnak.com/

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

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

-- Matrices and cases
-- taken from github.com/evesdropper

local generate_matrix = function(args, snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ " \\\\", "" }))
	end
	nodes[#nodes] = t(" \\\\")
	return sn(nil, nodes)
end

local generate_hom_matrix = function(args, snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		if j == 1 then
			table.insert(nodes, r(ins_indx,i(1)))
			table.insert(nodes, t("_{11}"))
		else
			table.insert(nodes, rep(1))
			table.insert(nodes, t("_{" .. tostring(j) .. "1}"))
		end
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, rep(1))
			table.insert(nodes, t("_{" .. tostring(j) .. tostring(k) .. "}"))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ " \\\\", "" }))
	end
	nodes[#nodes] = t(" \\\\")
	return sn(nil, nodes)
end

local generate_cases = function(args, snip)
	local rows = tonumber(snip.captures[1]) or 2 
	local cols = 2
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", sn(1,{t("    \\hfil "),i(1)})))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ " \\\\", "" }))
	end
    table.remove(nodes, #nodes)
	return sn(nil, nodes)
end

-- Snippets

return {

-- Math

-- Math alphabet identifiers

s({trig = "mc", name = "Calligraphic math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathcal{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mr", name = "Roman math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathrm{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mb", name = "Bold math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathbf{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "ms", name = "Sans serif math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathsf{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mt", name = "Typewriter math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathtt{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mn", name = "Normal math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathnormal{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mi", name = "Italic math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathit{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mf", name = "Euler Fraktur math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathfrak{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "mk", name = "Blackboard bold math font", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathbb{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

-- Display environments and alignment structures

s({trig = "mm", name = "Inline display", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("$"), d(1,get_visual), t("$")
    }
),

s({trig = "en", name = "Generic environment"},
    {
		t("\\begin{"), i(1,"env"), t("}"),
		t({"",""}), t("    "), d(2,get_visual),
		t({"",""}), t("\\end{"), rep(1), t("}")
    }
),

s({trig = "nn", name = "New equation"},
    {
        c(1,
            {
                {
                    t("\\begin{equation*}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{equation*}")
                },
                {
                    t("\\begin{equation}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{equation}")
                }
            }
        )
    }
),

s({trig = "ml", name = "New multline"},
    {
        c(1,
            {
                {
                    t("\\begin{multline}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{multline}")
                },
                {
                    t("\\begin{multline*}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{multline*}")
                }
            }
        )
    }
),

s({trig = "gap", name = "Multline gap"},
    {
        t("\\setlenght\\multlinegap{0pt}")
    }
),

s({trig = "sp", name = "New split"},
    {
		t("\\begin{split}"),
		t({"",""}), t("    "), d(1,get_visual),
		t({"",""}), t("\\end{split}")
    }
),

s({trig = "gg", name = "New gather"},
    {
        c(1,
            {
                {
                    t("\\begin{gather}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{gather}")
                },
                {
                    t("\\begin{gather*}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{gather*}")
                }
            }
        )
    }
),

s({trig = "aa", name = "New align"},
    {
        c(1,
            {
                {
                    t("\\begin{align*}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{align*}")
                },
                {
                    t("\\begin{align}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{align}")
                }
            }
        )
    }
),

s({trig = "fal", name = "New falign"},
    {
        c(1,
            {
                {
                    t("\\begin{falign}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{falign}")
                },
                {
                    t("\\begin{falign*}"),
					t({"",""}), t("    "), d(1,get_visual),
					t({"",""}), t("\\end{falign*}")
                }
            }
        )
    }
),

s({trig = "(%d?)cs", name = "New cases environment", snippetType = "autosnippet", regTrig = true},
	{
        t("\\begin{cases}"),
		t({"",""}), d(1,generate_cases),
		t({"",""}), t("\\end{cases}")
	},
    {condition = in_mathzone}
),

s({trig = "br", name = "Display line break", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\\\"),
		t({"",""}), i(1)
    },
    {condition = in_mathzone}
),

s({trig = "itr", name = "Short text between lines", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\intertext{"), v(1,"text"), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "tx", name = "Text inside display", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\text{"), v(1,"text"), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "dib", name = "Display page break", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\displaybreak")
    },
    {condition = in_mathzone}
),

s({trig = "dis", name = "Displaystyle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\displaystyle")
    },
    {condition = in_mathzone}
),

s({trig = "ty", name = "Textstyle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\textstyle")
    },
    {condition = in_mathzone}
),

-- Equation numbering and tags

s({trig = "ntg", name = "Suppress equation tag", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\notag")
    },
    {condition = in_mathzone}
),

s({trig = "tag", name = "Equation tag", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\tag{"), v(1,"tag"), t("}")
                },
                {
                    t("\\tag*{"), v(1,"tag"), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "teq", name = "Last number equation"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\theequation")
    }
),

-- Matrix-like environments

s({trig = "([bBpvV])(%d+)x(%d+)", name = "New matrix", snippetType = "autosnippet", regTrig = true},
    {
		t("\\begin{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}"),
		t({"",""}), d(1,generate_matrix),
		t({"",""}), t("\\end{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}")
    },
    {condition = in_mathzone}
),


s({trig = "([bBpvV])(%d+)h(%d+)", name = "New homogeneous matrix", snippetType = "autosnippet", regTrig = true},
    {
		t("\\begin{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}"),
		t({"",""}), d(1,generate_hom_matrix),
		t({"",""}), t("\\end{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}")
    },
    {condition = in_mathzone}
),


s({trig = "([bBpvV])gn", name = "New generic matrix", snippetType = "autosnippet", regTrig = true},
    {
        t("\\begin{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}"),
		t({"",""}), t("    "), i(1), t("_{11} & "), rep(1), t("_{12} & \\cdots & "), rep(1), t("_{1"), i(2), t("}"), t(" \\\\"),
		t({"",""}), t("    "), rep(1), t("_{21} & "), rep(1), t("_{22} & \\cdots & "), rep(1), t("_{2"), rep(2), t("}"), t(" \\\\"),
		t({"",""}), t("    "), t("\\vdots & \\vdots & \\ddots & \\vdots \\\\"),
		t({"",""}), t("    "), rep(1), t("_{"), i(3), t("1} & "), rep(1), t("_{"), rep(3), t("2} & \\cdots & "), rep(1), t("_{"), rep(3), rep(2), t("} \\\\"),
		t({"",""}), t("\\end{"), f(function(_, snip) return snip.captures[1] .. "matrix" end), t("}")
    },
    {condition = in_mathzone}
),

-- Subscripts and superscripts

s({trig = ";", name = "Short subscript", snippetType = "autosnippet", wordTrig = false},
    {
        t("_")
    },
    {condition = in_mathzone}
),

s({trig = ":", name = "Subscript", snippetType = "autosnippet", wordTrig = false},
    {
        t("_{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "´", name = "Short superscript", snippetType = "autosnippet", wordTrig = false},
    {
        t("^")
    },
    {condition = in_mathzone}
),

s({trig = "¨", name = "Superscript", snippetType = "autosnippet", wordTrig = false},
    {
        t("^{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "¨", name = "Superscript", snippetType = "autosnippet", wordTrig = false},
    {
        t("^{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "\'", name = "Subscript and superscript", snippetType = "autosnippet", wordTrig = false},
    {
		t("_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "st", name = "Stacking", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\substack{"), d(1,get_visual), t(" \\\\ "), i(2), t("}")
    },
    {condition = in_mathzone}
),

-- Compound structures

s({trig = "lxl", name = "Left relation arrow", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\xleftarrow{"), i(1,"top"), t("}")
		        },
		        {
        			t("\\xleftarrow["), i(1,"bottom"), t("]{"), i(2,"top"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "lxr", name = "Left relation arrow", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\xrightarrow{"), i(1,"top"), t("}")
		        },
		        {
        			t("\\xrightarrow["), i(1,"bottom"), t("]{"), i(2,"top"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "cf", name = "Continued fraction", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\cfrac{"), i(1,"num"), t("}{"),
					t({"",""}), t("    "), i(2,"den"),
					t({"",""}), t("}")
                },
                {
                    t("\\cfrac["), i(1,"num-alignment"), t("]{"), i(2,"num"), t("}{"),
					t({"",""}), t("    "), i(3,"den"),
					t({"",""}), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "bx", name = "Boxed formula", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\boxed{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "ff", name = "Fraction", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\frac{"), i(1), t("}{"), i(2), t("}")
                },
                {
                    t("\\dfrac{"), i(1), t("}{"), i(2), t("}")
                },
                {
                    t("\\tfrac{"), i(1), t("}{"), i(2), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "bm", name = "Binomial coefficient", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\binom{"), i(1), t("}{"), i(2), t("}")
                },
                {
                    t("\\dbinom{"), i(1), t("}{"), i(2), t("}")
                },
                {
                    t("\\tbinom{"), i(1), t("}{"), i(2), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Decorations

s({trig = "abv", name = "Place material above", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\overset{"), i(1,"above"), t("}{"), v(2,"material"), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "bel", name = "Place material below", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\underset{"), i(1,"below"), t("}{"), v(2,"material"), t("}")
    },
    {condition = in_mathzone}
),

-- Limiting positions

s({trig = "lim", name = "Above/below operator", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\limits")
    },
    {condition = in_mathzone}
),

s({trig = "nli", name = "Right of the operator", snippetType = "autosnippet"},
    {
        t("\\nolimits")
    },
    {condition = in_mathzone}
),

-- Relations

s({trig = "eq", name = "Congruence relation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\equiv")
    },
    {condition = in_mathzone}
),

s({trig = "md", name = "Mod operator", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Mod{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

-- local macro
s({trig = "mod", name = "Modular relation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
		            i(1,"..."), t(" \\equiv "), i(2,"..."), t(" \\pmod{"), i(3,"..."), t("}")
		        },
		        {
		            i(1,"..."), t(" \\not\\equiv "), i(2,"..."), t(" \\pmod{"), i(3,"..."), t("}")
		        },
		        {
		            i(1,"..."), t(" \\equiv "), i(2,"..."), t(" \\mod{"), i(3,"..."), t("}")
		        },
		        {
		            i(1,"..."), t(" \\not\\equiv "), i(2,"..."), t(" \\mod{"), i(3,"..."), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "sbg", name = "Left triangle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\vartriangleleft")
                },
                {
                    i(1,"\\ntriangleleft")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "sgc", name = "Right triangle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\vartriangleright")
                },
                {
                    i(1,"\\ntriangleright")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "ne", name = "Not equal", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ne")
    },
    {condition = in_mathzone}
),

s({trig = "nr", name = "Relation negation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\not")
    },
    {condition = in_mathzone}
),

s({trig = "app", name = "Approx", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\approx")
    },
    {condition = in_mathzone}
),

s({trig = "cn", name = "Congruent", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\cong")
                },
                {
                    i(1,"\\ncong")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "le", name = "Less or equal", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\le")
    },
    {condition = in_mathzone}
),

s({trig = "ge", name = "Greater or equal", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ge")
    },
    {condition = in_mathzone}
),

s({trig = "pc", name = "Precedes", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\prec")
                },
                {
                    i(1,"\\nprec")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "sx", name = "Succedes", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\succ")
                },
                {
                    i(1,"\\nsucc")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "re", name = "Relation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\sim")
                },
                {
                    i(1,"\\nsim")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Operators

s({trig = "opr", name = "Define new operator"},
    {
        c(1,
            {
                {
                    t("\\DeclareMathOperator{"), i(1,"cmd"), t("}{"), i(2,"text"), t("}")
                },
                {
                    t("\\DeclareMathOperator*{"), i(1,"cmd"), t("}{"), i(2,"text"), t("}")
                }
            }
        )
    }
),

s({trig = "ce", name = "Ceiling", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\lceil "), d(1,get_visual), t(" \\rceil")
                },
                {
                    t("\\left\\lceil "), d(1,get_visual), t(" \\right\\rceil")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "fl", name = "Floor", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\lfloor "), d(1,get_visual), t(" \\rfloor")
                },
                {
                    t("\\left\\lfloor "), d(1,get_visual), t(" \\right\\rfloor")
                }
            }
        )
        
    },
    {condition = in_mathzone}
),

s({trig = "sq", name = "Square root", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\sqrt{"), d(1,get_visual), t("}")
                },
                {
                    t("\\sqrt["), i(1,"n-th"), t("]{"), d(2,get_visual), t("}")
                },
                {
                    t("\\sqrt[\\leftroot{"), i(1,"x"), t("}\\uproot{"), i(2,"y"), t("} "), i(3,"n-th"), t("]{"), d(4,get_visual), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "imp", name = "Imaginary part", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Im")
    },
    {condition = in_mathzone}
),

s({trig = "rpa", name = "Real part", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Re")
    },
    {condition = in_mathzone}
),

s({trig = "opm", name = "Mod operator", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        i(1,"..."), t(" \\bmod "), i(2,"...")
    },
    {condition = in_mathzone}
),

s({trig = "mp", name = "Minus plus", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mp")
    },
    {condition = in_mathzone}
),

s({trig = "pm", name = "Plus minus", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\pm")
    },
    {condition = in_mathzone}
),

s({trig = "tm", name = "Times", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\times")
    },
    {condition = in_mathzone}
),

s({trig = "cd", name = "Centered dot", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cdot")
    },
    {condition = in_mathzone}
),

s({trig = "cir", name = "Circle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\circ")
    },
    {condition = in_mathzone}
),

s({trig = "opl", name = "Oplus", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\oplus")
    },
    {condition = in_mathzone}
),

s({trig = "omt", name = "Otimes", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\otimes")
    },
    {condition = in_mathzone}
),

s({trig = "dv", name = "Middle bar", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mid")
    },
    {condition = in_mathzone}
),

s({trig = "ndv", name = "Middle bar", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\centernot\\mid")
    },
    {condition = in_mathzone}
),

s({trig = "xm", name = "Maximum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\max")
                },
                {
                    t("\\max_{"), i(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "mu", name = "Minimum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\min")
                },
                {
                    t("\\min_{"), i(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "nf", name = "Infimum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\inf")
                },
                {
                    t("\\inf_{"), i(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "sr", name = "Supremum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\sup")
                },
                {
                    t("\\sup_{"), i(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "arg", name = "Argument", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arg")
    },
    {condition = in_mathzone}
),

s({trig = "deg", name = "Degree", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\deg")
    },
    {condition = in_mathzone}
),

s({trig = "det", name = "Determinant", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\det")
    },
    {condition = in_mathzone}
),

s({trig = "dim", name = "Dimension", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\dim")
    },
    {condition = in_mathzone}
),

s({trig = "gc", name = "Greatest common divisor", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\gcd")
    },
    {condition = in_mathzone}
),

s({trig = "hm", name = "Hom", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\hom")
    },
    {condition = in_mathzone}
),

s({trig = "kr", name = "Kernel", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ker")
    },
    {condition = in_mathzone}
),

s({trig = "lap", name = "Laplacian", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\nabla^2 ")
    },
    {condition = in_mathzone}
),

s({trig = "div", name = "Divergence", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\nabla\\cdot\\vv{"), i(1), t("}")
		        },
		        {
        			t("\\nabla\\cdot\\vec{"), i(1), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "cur", name = "Curl", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\nabla\\times\\vv{"), i(1), t("}")
		        },
		        {
        			t("\\nabla\\times\\vec{"), i(1), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "ba", name = "Bra", snippetType = "autosnippet"},
    {
        c(1,
            {
                {
                    t("\\bra{"), i(1), t("}")
                },
                {
                    t("\\bra*{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "kt", name = "Ket", snippetType = "autosnippet"},
    {
        c(1,
            {
                {
                    t("\\ket{"), i(1), t("}")
                },
                {
                    t("\\ket*{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "bk", name = "Braket", snippetType = "autosnippet"},
    {
        c(1,
            {
                {
                    t("\\braket{"), i(1), t("}{"), i(2), t("}")
                },
                {
                    t("\\braket*{"), i(1), t("}{"), i(2), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Operators with limits

s({trig = "lm", name = "Limit", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\lim_{"), i(1), t(" \\to "), i(2), t("}")
                },
                {
					i(1,"\\lim")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "lif", name = "liminf", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\liminf_{"), i(1), t(" \\to "), i(2), t("}")
                },
                {
					i(1,"\\liminf")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "lsu", name = "limsup", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\limsup_{"), i(1), t(" \\to "), i(2), t("}")
                },
                {
					i(1,"\\limsup")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "lvf", name = "varliminf", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\varliminf_{"), i(1), t(" \\to "), i(2), t("}")
                },
                {
					i(1,"\\varliminf")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "lvu", name = "varlimsup", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\varlimsup_{"), i(1), t(" \\to "), i(2), t("}")
                },
                {
					i(1,"\\varlimsup")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Functions

s({trig = "fn", name = "Function domain and codomain", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        i(1,"fun"), t(" : "), i(2,"dom"), t(" \\longrightarrow "), i(3,"cod")
    },
    {condition = in_mathzone}
),

s({trig = "fd", name = "Function definition"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\begin{align*}"),
		t({"",""}), t("    "), i(1,"fun"), t(" : "), i(2,"dom"), t(" & \\longrightarrow "), i(3,"cod"), t(" \\\\"),
		t({"",""}), t("    "), i(4,"point"), t(" & \\longmapsto "), i(5,"img"),
		t({"",""}), t("\\end{align*}")
    }
),

s({trig = "sni", name = "sin", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sin")
    },
    {condition = in_mathzone}
),

s({trig = "co", name = "cos", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cos")
    },
    {condition = in_mathzone}
),

s({trig = "tan", name = "tan", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\tan")
    },
    {condition = in_mathzone}
),

s({trig = "ot", name = "cot", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cot")
    },
    {condition = in_mathzone}
),

s({trig = "sc", name = "sec", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sec")
    },
    {condition = in_mathzone}
),

s({trig = "cc", name = "csc", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\csc")
    },
    {condition = in_mathzone}
),

s({trig = "asin", name = "arcsin", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arcsin")
    },
    {condition = in_mathzone}
),

s({trig = "acos", name = "arccos", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccos")
    },
    {condition = in_mathzone}
),

s({trig = "atan", name = "arctan", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arctan")
    },
    {condition = in_mathzone}
),

s({trig = "acot", name = "arccot", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccot")
    },
    {condition = in_mathzone}
),

s({trig = "asec", name = "arcsec", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arcsec")
    },
    {condition = in_mathzone}
),

s({trig = "acc", name = "arccsc", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccsc")
    },
    {condition = in_mathzone}
),

s({trig = "sinh", name = "sinh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sinh")
    },
    {condition = in_mathzone}
),

s({trig = "cosh", name = "cosh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cosh")
    },
    {condition = in_mathzone}
),

s({trig = "tanh", name = "tanh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\tanh")
    },
    {condition = in_mathzone}
),

s({trig = "coth", name = "coth", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\coth")
    },
    {condition = in_mathzone}
),

s({trig = "sh", name = "sech", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sech")
    },
    {condition = in_mathzone}
),

s({trig = "hcc", name = "csch", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\csch")
    },
    {condition = in_mathzone}
),

s({trig = "ahsin", name = "arcsinh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arcsinh")
    },
    {condition = in_mathzone}
),

s({trig = "ahcos", name = "arccosh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccosh")
    },
    {condition = in_mathzone}
),

s({trig = "ahtan", name = "arctanh", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arctanh")
    },
    {condition = in_mathzone}
),

s({trig = "ahcot", name = "arccoth", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccoth")
    },
    {condition = in_mathzone}
),

s({trig = "ahsec", name = "arcsech", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arcsech")
    },
    {condition = in_mathzone}
),

s({trig = "ahcc", name = "arccsch", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\arccsch")
    },
    {condition = in_mathzone}
),

s({trig = "xp", name = "exp", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\exp")
    },
    {condition = in_mathzone}
),

s({trig = "ln", name = "ln", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ln")
    },
    {condition = in_mathzone}
),

s({trig = "lg", name = "log", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\log")
    },
    {condition = in_mathzone}
),

-- Ellipsis

s({trig = "dd", name = "Lower dots", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ldots")
    },
    {condition = in_mathzone}
),

s({trig = "cr", name = "Centered dots", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cdots")
    },
    {condition = in_mathzone}
),

s({trig = "vd", name = "Vertical dots", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\vdots")
    },
    {condition = in_mathzone}
),

s({trig = "gd", name = "Diagonal dots", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ddots")
    },
    {condition = in_mathzone}
),

s({trig = "cln", name = "Colon", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t(":")
    },
    {condition = in_mathzone}
),

s({trig = "sln", name = "Semicolon", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t(";")
    },
    {condition = in_mathzone}
),

-- Horizontal extensions

s({trig = "ovr", name = "Overline", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\overline{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "und", name = "Underline", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\underline{"), d(1,get_visual), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "ovb", name = "Overbrace", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\overbrace{"), d(1,get_visual), t("}^{"), i(2,"top"), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "unb", name = "Underbrace", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\underbrace{"), d(1,get_visual), t("}_{"), i(2,"bottom"), t("}")
    },
    {condition = in_mathzone}
),

-- Delimiters

s({trig = "dp", name = "Parenthesis", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\left( "), d(1,get_visual), t(" \\right)")
    },
    {condition = in_mathzone}
),

s({trig = "ds", name = "Brackets", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\left[ "), d(1,get_visual), t(" \\right]")
    },
    {condition = in_mathzone}
),

s({trig = "bb", name = "Braces", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\{ "), d(1,get_visual), t(" \\}")
    },
    {condition = in_mathzone}
),

s({trig = "db", name = "Extensible braces", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\left\\{ "), d(1,get_visual), t(" \\right\\}")
    },
    {condition = in_mathzone}
),

s({trig = "dk", name = "Angle brackets", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\left\\langle "), d(1,get_visual), t(" \\right\\rangle")
                },
                {
                    t("\\langle "), d(1,get_visual), t(" \\rangle")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "da", name = "Pipes", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\left\\lvert "), d(1,get_visual), t(" \\right\\rvert")
                },
                {
                    t("\\lvert "), d(1,get_visual), t(" \\rvert")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "dn", name = "Double pipes", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\left\\lVert "), d(1,get_visual), t(" \\right\\rVert")
                },
                {
                    t("\\lVert "), d(1,get_visual), t(" \\rVert")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "big", name = "Big-d delimiters", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\big")
                },
                {
                    i(1,"\\Big")
                },
                {
                    i(1,"\\bigg")
                },
                {
                    i(1,"\\Bigg")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Spacing commands

s({trig = "thp", name = "Thin space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\,")
    },
    {condition = in_mathzone}
),

s({trig = "mdn", name = "Medium space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\:")
    },
    {condition = in_mathzone}
),

s({trig = "tkp", name = "Thick space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\;")
    },
    {condition = in_mathzone}
),

s({trig = "enp", name = "Enskip", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\enskip")
    },
    {condition = in_mathzone}
),

s({trig = "qu", name = "Quad", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\quad")
    },
    {condition = in_mathzone}
),

s({trig = "qq", name = "Double quad", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\qquad")
    },
    {condition = in_mathzone}
),

s({trig = "thn", name = "Negative thin space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\!")
    },
    {condition = in_mathzone}
),

s({trig = "men", name = "Negative medium space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\negmedspace")
    },
    {condition = in_mathzone}
),

s({trig = "tkn", name = "Negative thick space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\negthickspace")
    },
    {condition = in_mathzone}
),

s({trig = "hs", name = "Horizontal space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\hspace{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "vs", name = "Vertical space", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\vspace{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

-- Greek alphabet

s({trig = "[.]a", name = "Alpha", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\alpha")
    },
    {condition = in_mathzone}
),

s({trig = "[.]b", name = "Beta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\beta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]c", name = "Chi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\chi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]D", name = "Uppercase delta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Delta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]d", name = "Lowercase delta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\delta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]e", name = "Epsilon", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
		t("\\varepsilon")
    },
    {condition = in_mathzone}
),

s({trig = "[.]G", name = "Uppercase gamma", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Gamma")
    },
    {condition = in_mathzone}
),

s({trig = "[.]g", name = "Lowercase gamma", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\gamma")
    },
    {condition = in_mathzone}
),

s({trig = "[.]h", name = "Eta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\eta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]i", name = "Iota", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\iota")
    },
    {condition = in_mathzone}
),

s({trig = "[.]k", name = "Kappa", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\kappa")
    },
    {condition = in_mathzone}
),

s({trig = "[.]L", name = "Uppercase lambda", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Lambda")
    },
    {condition = in_mathzone}
),

s({trig = "[.]l", name = "Lowercase lambda", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\lambda")
    },
    {condition = in_mathzone}
),

s({trig = "[.]m", name = "Mu", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mu")
    },
    {condition = in_mathzone}
),

s({trig = "[.]n", name = "Nu", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\nu")
    },
    {condition = in_mathzone}
),

s({trig = "[.]O", name = "Uppercase omega", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Omega")
    },
    {condition = in_mathzone}
),

s({trig = "[.]o", name = "Lowercase omega", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\omega")
    },
    {condition = in_mathzone}
),

s({trig = "[.]Ph", name = "Uppercase phi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Phi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]ph", name = "Lowecase phi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
		t("\\phi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]Pi", name = "Uppercase pi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Pi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]pi", name = "Lowercase pi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\pi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]Ps", name = "Uppercase psi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Psi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]ps", name = "Lowercase psi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\psi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]r", name = "Rho", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\rho")
    },
    {condition = in_mathzone}
),

s({trig = "[.]S", name = "Uppercase sigma", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Sigma")
    },
    {condition = in_mathzone}
),

s({trig = "[.]s", name = "Lowercase sigma", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sigma")
    },
    {condition = in_mathzone}
),

s({trig = "[.]ta", name = "Tau", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\tau")
    },
    {condition = in_mathzone}
),

s({trig = "[.]Th", name = "Uppercase theta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Theta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]th", name = "Lowercase theta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\theta")
    },
    {condition = in_mathzone}
),

s({trig = "[.]U", name = "Uppercase upsilon", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Upsilon")
    },
    {condition = in_mathzone}
),

s({trig = "[.]u", name = "Lowecase upsilon", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\upsilon")
    },
    {condition = in_mathzone}
),

s({trig = "[.]X", name = "Uppercase xi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\Xi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]x", name = "Lowercase xi", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\xi")
    },
    {condition = in_mathzone}
),

s({trig = "[.]z", name = "Zeta", snippetType = "autosnippet", regTrig = true},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\zeta")
    },
    {condition = in_mathzone}
),

-- Letter-shaped symbols

s({trig = "ha", name = "Aleph", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\aleph")
    },
    {condition = in_mathzone}
),

s({trig = "hb", name = "Beth", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\beth")
    },
    {condition = in_mathzone}
),

s({trig = "hd", name = "Daleth", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\daleth")
    },
    {condition = in_mathzone}
),

s({trig = "hg", name = "Gimel", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\gimel")
    },
    {condition = in_mathzone}
),

s({trig = "ll", name = "ell", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ell")
    },
    {condition = in_mathzone}
),

s({trig = "cm", name = "Set complement", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\complement")
    },
    {condition = in_mathzone}
),

s({trig = "hr", name = "hbar", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\hbar")
    },
    {condition = in_mathzone}
),

s({trig = "hl", name = "hslash", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\hslash")
    },
    {condition = in_mathzone}
),

s({trig = "pt", name = "Partial", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\partial")
    },
    {condition = in_mathzone}
),

-- Miscellaneous symbols

s({trig = "dl", name = "Dollar sign", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\$")
    },
    {condition = in_mathzone}
),

s({trig = "hh", name = "Numeral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\#")
    },
    {condition = in_mathzone}
),

s({trig = "fy", name = "Infinity", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\infty")
    },
    {condition = in_mathzone}
),

s({trig = "pr", name = "Prime", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\prime")
    },
    {condition = in_mathzone}
),

s({trig = "per", name = "Percentaje", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\%")
    },
    {condition = in_mathzone}
),

s({trig = "amp", name = "Ampersand", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\&")
    },
    {condition = in_mathzone}
),

s({trig = "ang", name = "Angle", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\angle")
    },
    {condition = in_mathzone}
),

s({trig = "nb", name = "Nabla", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\nabla")
    },
    {condition = in_mathzone}
),

s({trig = "ch", name = "Section symbol"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\S")
    }
),

-- Accents

s({trig = "dr", name = "Dot accent", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
					t("\\dot{"), v(1,"..."), t("}")
		        },
		        {
					t("\\ddot{"), v(1,"..."), t("}")
		        },
		        {
					t("\\dddot{"), v(1,"..."), t("}")
		        },
		        {
					t("\\ddddot{"), v(1,"..."), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "ht", name = "Hat", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\hat{"), v(1,"..."), t("}")
                },
                {
                    t("\\widehat{"), v(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "rng", name = "Math ring", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\mathring{"), v(1,"..."), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "til", name = "Tilde", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\tilde{"), i(1), t("}")
                },
                {
                    t("\\widetilde{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "vv", name = "Vector", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\vv{"), v(1,"..."), t("}")
                },
                {
                    t("\\vec{"), v(1,"..."), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

-- Logic

s({trig = "fa", name = "For all", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\forall")
    },
    {condition = in_mathzone}
),

s({trig = "ex", name = "Exists", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\exists")
    },
    {condition = in_mathzone}
),

s({trig = "nx", name = "Not exist", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\nexists")
    },
    {condition = in_mathzone}
),

s({trig = "lt", name = "Logic negation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\lnot")
    },
    {condition = in_mathzone}
),

s({trig = "lan", name = "Logic and", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\land")
    },
    {condition = in_mathzone}
),

s({trig = "lor", name = "Logic or", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\lor")
    },
    {condition = in_mathzone}
),

s({trig = "ip", name = "Implies", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\implies")
    },
    {condition = in_mathzone}
),

s({trig = "ib", name = "Implied by", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\impliedby")
    },
    {condition = in_mathzone}
),

s({trig = "iff", name = "If and only if", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\iff")
    },
    {condition = in_mathzone}
),

-- Sets and inclusion

s({trig = "in", name = "Belongs to", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\in")
    },
    {condition = in_mathzone}
),

s({trig = "ntn", name = "Not in", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\notin")
    },
    {condition = in_mathzone}
),

s({trig = "na", name = "Owns", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\ni")
    },
    {condition = in_mathzone}
),

s({trig = "vc", name = "Empty set", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\emptyset")
                },
                {
                    i(1,"\\varnothing")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "nun", name = "Union", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cup")
    },
    {condition = in_mathzone}
),

s({trig = "bun", name = "Big union", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcup")
    },
    {condition = in_mathzone}
),

s({trig = "sun", name = "Big subscript union", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcup_{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "dun", name = "Big definite union", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcup_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "nit", name = "Intersection", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\cap")
    },
    {condition = in_mathzone}
),

s({trig = "bit", name = "Big intersection", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcap")
    },
    {condition = in_mathzone}
),

s({trig = "sit", name = "Big subscript intersection", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcap_{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "dit", name = "Big definite intersection", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigcap_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "sf", name = "Set difference", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\setminus")
    },
    {condition = in_mathzone}
),

s({trig = "sbs", name = "Subset", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\subset")
    },
    {condition = in_mathzone}
),

s({trig = "sbq", name = "Subset or equals", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\subseteq")
                },
                {
                    i(1,"\\nsubseteq")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "sus", name = "Contains", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\supset")
    },
    {condition = in_mathzone}
),

s({trig = "suq", name = "Contains or equals", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\supseteq")
                },
                {
                    i(1,"\\nsupseteq")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "setd", name = "Dots set", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\{ "), i(1), t(" \\std "), i(2), t(" \\}")
    },
    {condition = in_mathzone}
),

s({trig = "setb", name = "Bar set", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\{ "), i(1), t(" \\mid "), i(2), t(" \\}")
    },
    {condition = in_mathzone}
),

-- Arrows

s({trig = "rar", name = "Long right arrow", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\longrightarrow")
    },
    {condition = in_mathzone}
),

s({trig = "lar", name = "Long left arrow", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\longleftarrow")
    },
    {condition = in_mathzone}
),

s({trig = "to", name = "Long maps to", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\longmapsto")
    },
    {condition = in_mathzone}
),

-- Sums

s({trig = "sm", name = "Subscript sum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\sum_{"), i(1), t("}")
		        },
		        {
        			i(1,"\\sum")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "ss", name = "Definite sum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\sum_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "sos", name = "Subscript o-sum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigoplus_{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "nos", name = "Definite o-sum", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigoplus_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

-- Products

s({trig = "sp", name = "Subscript product", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\prod_{"), i(1), t("}")
		        },
		        {
        			i(1,"\\prod")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "pp", name = "Definite product", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\prod_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "sop", name = "Subscript o-product", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigotimes_{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "nop", name = "Definite o-product", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\bigotimes_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

-- Derivatives

s({trig = "df", name = "Differential", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\dx{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "der", name = "Derivative", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\der{"), i(1,"func"), t("}{"), i(2,"var"), t("}")
		        },
		        {
        			t("\\Der{"), i(1,"func"), t("}{"), i(2,"var"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "ndr", name = "n-th derivative", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\ndr{"), i(1,"n"), t("}{"), i(2,"func"), t("}{"), i(3,"var"), t("}")
		        },
		        {
        			t("\\Ndr{"), i(1,"n"), t("}{"), i(2,"func"), t("}{"), i(3,"var"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "pdr", name = "Partial derivative", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\pdr{"), i(1,"func"), t("}{"), i(2,"var"), t("}")
		        },
		        {
        			t("\\Pdr{"), i(1,"func"), t("}{"), i(2,"var"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "npd", name = "n-th partial derivative", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		c(1,
		    {
		        {
        			t("\\npd{"), i(1,"n"), t("}{"), i(2,"func"), t("}{"), i(3,"var"), t("}")
		        },
		        {
        			t("\\Npd{"), i(1,"n"), t("}{"), i(2,"func"), t("}{"), i(3,"var"), t("}")
		        }
		    }
		)
    },
    {condition = in_mathzone}
),

s({trig = "evl", name = "Derivative evaluation", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\evl{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

-- Integrals

s({trig = "itn", name = "Integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\int")
                },
                {
                    i(1,"\\oint")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "its", name = "Subscript integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\int_{"), i(1), t("}")
                },
                {
                    t("\\oint_{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itd", name = "Definite integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        t("\\int_{"), i(1), t("}^{"), i(2), t("}")
    },
    {condition = in_mathzone}
),

s({trig = "itbn", name = "Double integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\iint")
                },
                {
                    i(1,"\\oiint")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itbs", name = "Double integral subscript", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\iint_{"), i(1), t("}")
                },
                {
                    t("\\oiint_{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "ittn", name = "Triple integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\iiint")
                },
                {
                    i(1,"\\oiiint")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itts", name = "Triple integral subscript", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\iiint_{"), i(1), t("}")
                },
                {
                    t("\\oiiint_{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itqn", name = "Quadruple integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    i(1,"\\iiiint")
                },
                {
                    i(1,"\\oiiint")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itqs", name = "Quadruple integral subscript", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
        c(1,
            {
                {
                    t("\\iiint_{"), i(1), t("}")
                },
                {
                    t("\\oiiint_{"), i(1), t("}")
                }
            }
        )
    },
    {condition = in_mathzone}
),

s({trig = "itmn", name = "Multiple integral", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		t("\\idotsint")
    },
    {condition = in_mathzone}
),

s({trig = "itms", name = "Multiple integral subscript", snippetType = "autosnippet"},
    {
		f(function(_,snip) return snip.captures[1] end),
		t("\\idotsint_{"), i(1), t("}")
    },
    {condition = in_mathzone}
),

}
