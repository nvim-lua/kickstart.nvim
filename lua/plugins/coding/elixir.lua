return {
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    ft = { 'ex', 'exs', 'heex', 'eex', 'elixir' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local elixir = require('elixir')
      
      -- Configure elixir-tools with LSP disabled (handled by lspconfig)
      elixir.setup({
        -- Disable the built-in LSP client to avoid conflicts
        elixirls = { enable = false },
        
        -- Enable non-LSP features
        credo = { enable = true },
        projectionist = { enable = true },
        
        -- Configure the test runner
        test_runner = {
          enabled = true,
          runner = 'exunit', -- or 'exunit_individual' for individual test runs
        },
        
        -- Enable mix integration
        mix = {
          enabled = true,
          format_on_save = false, -- Disabled to prevent file changed warnings
        },
      })
      
      -- Keymaps are now in core/keymaps.lua with <leader>lx prefix
    end,
  },
}
