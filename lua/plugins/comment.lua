return {
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        astro = "<!-- %s -->",
        axaml = "<!-- %s -->",
        blueprint = "// %s",
        c = "// %s",
        c_sharp = "// %s",
        clojure = { ";; %s", "; %s" },
        cpp = "// %s",
        cs_project = "<!-- %s -->",
        css = "/* %s */",
        cue = "// %s",
        fsharp = "// %s",
        fsharp_project = "<!-- %s -->",
        gleam = "// %s",
        glimmer = "{{! %s }}",
        handlebars = "{{! %s }}",
        hcl = "# %s",
        html = "<!-- %s -->",
        ini = "; %s",
        javascript = {
          "// %s",                   -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        kdl = "// %s",
        lua = { "-- %s", "--- %s" }, -- langs can have multiple commentstrings
        ocaml = "(* %s *)",
        php = "// %s",
        rego = "# %s",
        rescript = "// %s",
        rust = { "// %s", "/* %s */", "/// %s" },
        sql = "-- %s",
        svelte = "<!-- %s -->",
        templ = "// %s",
        terraform = "# %s",
        tsx = {
          "// %s",                   -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        twig = "{# %s #}",
        typescript = "// %s",
        vim = '" %s',
        vue = "<!-- %s -->",
        xaml = "<!-- %s -->",
        xml = "<!-- %s -->",
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

}
