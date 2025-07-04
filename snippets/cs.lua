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
    using System;

    namespace {};

    class Program
    {{
        static void Main(string[] args)
        {{
            {}
        }}
    }}
  ]], { i(1, "MyApp"), i(2, 'Console.WriteLine("Hello, World!");') }), snippet_opts),

  -- Namespace
  s("namespace", fmt([[
    namespace {};

    {}
  ]], { i(1, "MyNamespace"), i(2) }), snippet_opts),

  -- Class
  s("class", fmt([[
    public class {}
    {{
        {}
    }}
  ]], { i(1, "MyClass"), i(2) }), snippet_opts),

  -- Method
  s("method", fmt([[
    public {} {}({})
    {{
        {}
    }}
  ]], { i(1, "void"), i(2, "MyMethod"), i(3), i(4) }), snippet_opts),

  -- Property
  s("prop", fmt([[
    public {} {} {{ get; set; }}
  ]], { i(1, "string"), i(2, "MyProperty") }), snippet_opts),

  -- Auto property with init
  s("propi", fmt([[
    public {} {} {{ get; init; }}
  ]], { i(1, "string"), i(2, "MyProperty") }), snippet_opts),

  -- Constructor
  s("ctor", fmt([[
    public {}({})
    {{
        {}
    }}
  ]], { i(1, "ClassName"), i(2), i(3) }), snippet_opts),

  -- Interface
  s("interface", fmt([[
    public interface {}
    {{
        {}
    }}
  ]], { i(1, "IMyInterface"), i(2) }), snippet_opts),

  -- For loop
  s("for", fmt([[
    for (int {} = 0; {} < {}; {}++)
    {{
        {}
    }}
  ]], { i(1, "i"), i(1), i(2, "10"), i(1), i(3) }), snippet_opts),

  -- Foreach loop
  s("foreach", fmt([[
    foreach ({} {} in {})
    {{
        {}
    }}
  ]], { i(1, "var"), i(2, "item"), i(3, "collection"), i(4) }), snippet_opts),

  -- If statement
  s("if", fmt([[
    if ({})
    {{
        {}
    }}
  ]], { i(1, "condition"), i(2) }), snippet_opts),

  -- Console.WriteLine
  s("cw", fmt([[
    Console.WriteLine({});
  ]], { i(1, '"Hello"') }), snippet_opts),

  -- Console.Write
  s("cwn", fmt([[
    Console.Write({});
  ]], { i(1, '"Hello"') }), snippet_opts),

  -- Try-catch
  s("try", fmt([[
    try
    {{
        {}
    }}
    catch ({})
    {{
        {}
    }}
  ]], { i(1), i(2, "Exception ex"), i(3, "throw;") }), snippet_opts),

  -- Variable declaration
  s("var", fmt([[
    var {} = {};
  ]], { i(1, "name"), i(2, "value") }), snippet_opts),

  -- String variable
  s("string", fmt([[
    string {} = {};
  ]], { i(1, "name"), i(2, '""') }), snippet_opts),

  -- Record
  s("record", fmt([[
    public record {}({});
  ]], { i(1, "MyRecord"), i(2, "string Name") }), snippet_opts),

  -- List declaration
  s("list", fmt([[
    List<{}> {} = [{}];
  ]], { i(1, "string"), i(2, "list"), i(3) }), snippet_opts),

  -- Dictionary declaration
  s("dict", fmt([[
    Dictionary<{}, {}> {} = [];
  ]], { i(1, "string"), i(2, "string"), i(3, "dict") }), snippet_opts),

  -- Array declaration
  s("array", fmt([[
    {}[] {} = [{}];
  ]], { i(1, "string"), i(2, "array"), i(3) }), snippet_opts),
}