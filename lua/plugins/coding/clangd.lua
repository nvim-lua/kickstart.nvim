---@diagnostic disable: undefined-global
return {
  "p00f/clangd_extensions.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  opts = {
    inlay_hints = { inline = false },
    ast = {
      role_icons = {
        type = "🄣",
        declaration = "🄓",
        expression = "🄔",
        statement = ";",
        specifier = "🄢",
        ["template argument"] = "🆃",
      },
      kind_icons = {
        Compound = "🄲",
        Recovery = "🅁",
        TranslationUnit = "🅄",
        PackExpansion = "🄿",
        TemplateTypeParm = "🅃",
        TemplateTemplateParm = "🅃",
        TemplateParamObject = "🅃",
      },
    },
  },
}
