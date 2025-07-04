local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Configure snippet options
local snippet_opts = {
  condition = function()
    return not ls.in_snippet()
  end,
  show_condition = function()
    return not ls.in_snippet()
  end
}

return {
  -- Complete main setup
  s("main", fmt([[
    package main

    import "fmt"

    func main() {{
        {}
    }}
  ]], { i(1, 'fmt.Println("Hello, World!")') }), snippet_opts),

  -- Package declaration
  s("pkg", fmt([[
    package {}
  ]], { i(1, "main") }), snippet_opts),

  -- Function
  s("func", fmt([[
    func {}({}) {{
        {}
    }}
  ]], { i(1, "name"), i(2), i(3) }), snippet_opts),

  -- Function with return
  s("funcr", fmt([[
    func {}() {} {{
        {}
    }}
  ]], { i(1, "name"), i(2, "string"), i(3, 'return ""') }), snippet_opts),

  -- If error
  s("iferr", fmt([[
    if err != nil {{
        {}
    }}
  ]], { i(1, "return err") }), snippet_opts),

  -- For loop
  s("for", fmt([[
    for {} {{
        {}
    }}
  ]], { i(1, "i := 0; i < 10; i++"), i(2) }), snippet_opts),

  -- Printf
  s("pf", fmt([[
    fmt.Printf("{}\n", {})
  ]], { i(1, "%v"), i(2, "value") }), snippet_opts),

  -- Println
  s("pl", fmt([[
    fmt.Println({})
  ]], { i(1, '"Hello"') }), snippet_opts),

  -- Variable declaration
  s("var", fmt([[
    var {} {}
  ]], { i(1, "name"), i(2, "string") }), snippet_opts),

  -- Short variable declaration
  s(":=", fmt([[
    {} := {}
  ]], { i(1, "name"), i(2, "value") }), snippet_opts),

  -- Struct
  s("struct", fmt([[
    type {} struct {{
        {}
    }}
  ]], { i(1, "Name"), i(2, "Field string") }), snippet_opts),

  -- Interface
  s("interface", fmt([[
    type {} interface {{
        {}
    }}
  ]], { i(1, "Name"), i(2, "Method()") }), snippet_opts),

  -- Test function
  s("test", fmt([[
    func Test{}(t *testing.T) {{
        {}
    }}
  ]], { i(1, "Name"), i(2) }), snippet_opts),

  -- Method
  s("method", fmt([[
    func ({} *{}) {}() {{
        {}
    }}
  ]], { i(1, "r"), i(2, "Receiver"), i(3, "Method"), i(4) }), snippet_opts),

  -- Goroutine
  s("go", fmt([[
    go func() {{
        {}
    }}()
  ]], { i(1) }), snippet_opts),

  -- Channel
  s("chan", fmt([[
    {} := make(chan {})
  ]], { i(1, "ch"), i(2, "string") }), snippet_opts),

  -- Defer
  s("defer", fmt([[
    defer {}
  ]], { i(1, "cleanup()") }), snippet_opts),
}