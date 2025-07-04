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
    fn main() {{
        {}
    }}
  ]], { i(1, 'println!("Hello, World!");') }), snippet_opts),

  -- Function
  s("fn", fmt([[
    fn {}({}) {{
        {}
    }}
  ]], { i(1, "name"), i(2), i(3) }), snippet_opts),

  -- Function with return
  s("fnr", fmt([[
    fn {}({}) -> {} {{
        {}
    }}
  ]], { i(1, "name"), i(2), i(3, "()"), i(4) }), snippet_opts),

  -- Struct
  s("struct", fmt([[
    struct {} {{
        {}: {},
    }}
  ]], { i(1, "Name"), i(2, "field"), i(3, "String") }), snippet_opts),

  -- Enum
  s("enum", fmt([[
    enum {} {{
        {},
    }}
  ]], { i(1, "Name"), i(2, "Variant") }), snippet_opts),

  -- Implementation
  s("impl", fmt([[
    impl {} {{
        {}
    }}
  ]], { i(1, "Name"), i(2) }), snippet_opts),

  -- Trait
  s("trait", fmt([[
    trait {} {{
        {}
    }}
  ]], { i(1, "Name"), i(2) }), snippet_opts),

  -- Match statement
  s("match", fmt([[
    match {} {{
        {} => {},
        _ => {},
    }}
  ]], { i(1, "value"), i(2, "pattern"), i(3), i(4) }), snippet_opts),

  -- If let
  s("iflet", fmt([[
    if let {} = {} {{
        {}
    }}
  ]], { i(1, "Some(value)"), i(2, "option"), i(3) }), snippet_opts),

  -- For loop
  s("for", fmt([[
    for {} in {} {{
        {}
    }}
  ]], { i(1, "item"), i(2, "iterator"), i(3) }), snippet_opts),

  -- While loop
  s("while", fmt([[
    while {} {{
        {}
    }}
  ]], { i(1, "condition"), i(2) }), snippet_opts),

  -- Loop
  s("loop", fmt([[
    loop {{
        {}
    }}
  ]], { i(1) }), snippet_opts),

  -- If statement
  s("if", fmt([[
    if {} {{
        {}
    }}
  ]], { i(1, "condition"), i(2) }), snippet_opts),

  -- Variable declaration
  s("let", fmt([[
    let {} = {};
  ]], { i(1, "name"), i(2, "value") }), snippet_opts),

  -- Mutable variable
  s("letm", fmt([[
    let mut {} = {};
  ]], { i(1, "name"), i(2, "value") }), snippet_opts),

  -- Print
  s("print", fmt([[
    println!("{}", {});
  ]], { i(1, "{}"), i(2, "value") }), snippet_opts),

  -- Debug print
  s("dbg", fmt([[
    dbg!({});
  ]], { i(1, "value") }), snippet_opts),

  -- Vector
  s("vec", fmt([[
    let {} = vec![{}];
  ]], { i(1, "name"), i(2) }), snippet_opts),

  -- HashMap
  s("hashmap", fmt([[
    let mut {} = HashMap::new();
  ]], { i(1, "map") }), snippet_opts),

  -- Result match
  s("result", fmt([[
    match {} {{
        Ok({}) => {},
        Err({}) => {},
    }}
  ]], { i(1, "result"), i(2, "value"), i(3), i(4, "err"), i(5) }), snippet_opts),

  -- Option match
  s("option", fmt([[
    match {} {{
        Some({}) => {},
        None => {},
    }}
  ]], { i(1, "option"), i(2, "value"), i(3), i(4) }), snippet_opts),

  -- Test function
  s("test", fmt([[
    #[test]
    fn test_{}() {{
        {}
    }}
  ]], { i(1, "name"), i(2) }), snippet_opts),

  -- Derive
  s("derive", fmt([[
    #[derive({})]
  ]], { i(1, "Debug, Clone") }), snippet_opts),

  -- Module
  s("mod", fmt([[
    mod {} {{
        {}
    }}
  ]], { i(1, "name"), i(2) }), snippet_opts),

  -- Use statement
  s("use", fmt([[
    use {};
  ]], { i(1, "std::collections::HashMap") }), snippet_opts),
}