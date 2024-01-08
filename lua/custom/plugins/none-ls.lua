return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          disabled_filetypes = { 'javascript', 'typescript', 'json' } -- Use biome
        }),
        null_ls.builtins.formatting.biome,
        -- null_ls.builtins.diagnostics.biome,
      }
    })
  end
}
