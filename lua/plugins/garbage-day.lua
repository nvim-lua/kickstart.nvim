-- Garbage collector that stops inactive LSP clients to free RAM
return {
  'zeioth/garbage-day.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  opts = {
    -- Collect garbage after 10 minutes of inactivity
    grace_period = 60 * 10,
    -- Exclude null-ls and other special clients
    excluded_lsp_clients = { 'omnisharp', 'null-ls', 'none-ls' },
    -- Show notifications when clients are stopped
    notifications = true,
    -- Garbage collection settings
    aggressive_mode = false,  -- Be gentle with GC
    -- Adjust Lua's GC parameters for better performance
    gc_settings = {
      pause = 110,    -- Lower pause for more frequent but shorter GC pauses
      step_mul = 100, -- Lower step multiplier for smoother collection
    },
  },
}
