-- C# / .NET: https://github.com/seblyng/roslyn.nvim
--
-- Uses the Roslyn language server (the same one VS Code's C# Dev Kit uses), installed by Mason
-- as the `roslyn` package (see `ensure_installed` in init.lua).
--
-- Opening a .cs file finds the nearest .sln/.slnx/.csproj. When several solutions are found,
-- run `:Roslyn target` to pick one. `:Roslyn restart` restarts the server.

vim.pack.add { 'https://github.com/seblyng/roslyn.nvim' }

require('roslyn').setup {
  -- Keep diagnostics scoped to open files; set to 'full' for whole-solution diagnostics (slower)
  broad_search = false,
}

vim.lsp.config('roslyn', {
  settings = {
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
    ['csharp|completion'] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
    },
    ['csharp|background_analysis'] = {
      dotnet_analyzer_diagnostics_scope = 'openFiles',
      dotnet_compiler_diagnostics_scope = 'fullSolution',
    },
  },
})
