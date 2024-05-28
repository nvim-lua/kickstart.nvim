return {
  "aperezdc/vim-template",
  -- Change init to config, and then tell when to load
  -- config only works for lua modules that are "required" by nvim.
  init = function()
      vim.g.templates_directory = "~/documents/latex-templates/"
      vim.g.templates_no_builtin_templates = true
      vim.g.templates_global_name_prefix = "template:"
      vim.g.templates_name_prefix = "template:"
      vim.g.templates_no_autocmd = true
    -- vim.cmd("let g:templates_no_autocmd=1")
  end,
  -- cmd = "Template",
}
