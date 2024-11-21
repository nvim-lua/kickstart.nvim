local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {


-- Tabular material

s({trig = "tab", name = "Table environment"},
    {
        t("\\begin{table}["), i(1,"opt"), t("]"),
		t({"",""}), t("\\begin{tabular}{"), i(2,"cols"), t("}"),
		t({"",""}), t("    "), i(3),
		t({"",""}), t("\\end{tabular}"),
		t({"",""}), t("\\end{table}")
    }
),

s({trig = "rr", name = "Array environment"},
    {
        t("\\begin{array}{"), i(1,"cols"), t("}"),
		t({"",""}), t("    "), i(2),
		t({"",""}), t("\\end{array}")
    }
),

s({trig = "he", name = "Break line height"},
    {
        t("\\\\["), i(1), t("]"),
		t({"",""})
    }
),

s({trig = "hyp", name = "Hyphenate text correctly"},
    {
        t("\\hspace{0pt}")
    }
),

s({trig = "bck", name = "Redefine \\\\ last column"},
    {
        t("\\arraybackslash")
    }
),

s({trig = "lt", name = "Align text to left"},
    {
        t("\\raggedleft")
    }
),

s({trig = "cr", name = "Align text to center"},
    {
        t("\\centering")
    }
),

s({trig = "rt", name = "Align text to right"},
    {
        t("\\raggedright")
    }
),

s({trig = "hn", name = "Horizontal line"},
    {
        t("\\hline"),
		t({"",""})
    }
),

s({trig = "br", name = "Tabular row break"},
    {
        t("\\\\"),
		t({"",""}), i(1)
    }
),

-- Tabular environment preamble options

s({trig = "pc", name = "Top column"},
    {
        t("p{"), i(1,"width"), t("}")
    }
),

s({trig = "cop", name = "num copies of opts"},
    {
        t("*{"), i(1,"num"), t("}{"), i(2,"opts"), t("}")
    }
),

s({trig = "mc", name = "Vertically centered column"},
    {
        t("m{"), i(1,"width"), t("}")
    }
),

s({trig = "bc", name = "Bottom column"},
    {
        t("b{"), i(1,"width"), t("}")
    }
),

s({trig = "bl", name = "Before column options"},
    {
        t(">{"), i(1,"decl"), t("}")
    }
),

s({trig = "af", name = "After column options"},
    {
        t("<{"), i(1,"decl"), t("}")
    }
),

-- Floats

s({trig = "cpt", name = "Caption"},
    {
        c(1,
            {
                {
                    t("\\caption{"), i(1,"text"), t("}")
                },
                {
                    t("\\caption["), i(1,"list-entry"), t("]{"), i(2,"text"), t("}")
                }
            }
        )
    }
),

s({trig = "cof", name = "Caption of"},
    {
        c(1,
            {
                {
                    t("\\captionof{"), i(1,"type"), t("}{"), i(2,"text"), t("}")
                },
                {
                    t("\\captionof{"), i(1,"type"), t("}["), i(2,"list-entry"), t("]{"), i(3,"text"), t("}")
                },
                {
                    t("\\captionof*{"), i(1,"type"), t("}{"), i(2,"text"), t("}")
                }
            }
        )
    }
),

s({trig = "sbf", name = "Subfloat"},
    {
        c(1,
            {
                {
                    t("\\subfloat{"), i(1,"object"), t("}")
                },
                {
                    t("\\subfloat["), i(1,"caption"), t("]{"), i(2,"object"), t("}")
                },
                {
                    t("\\subfloat["), i(1,"list-entry"), t("]["), i(2,"caption"), t("]{"), i(3,"object"), t("}")
                }
            }
        )
    }
),

s({trig = "snt", name = "Sub-numbers for tables"},
    {
        t("\\begin{subtables}"),
		t({"",""}), t("    "), i(1),
		t({"",""}), t("\\end{subtables}")
    }
),

s({trig = "snf", name = "Sub-numbers for figures"},
    {
        t("\\begin{subfigures}"),
		t({"",""}), t("    "), i(1),
		t({"",""}), t("\\end{subfigures}")
    }
),

}
