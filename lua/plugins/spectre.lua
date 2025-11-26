return {
  -- other plugins …

  -- nvim-spectre
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- optionally configure lazy loading:
    -- lazy = true,   -- default
    -- or set events/commands/ft if desired

    -- you can also provide setup/options here if you want:
    config = function()
      require("spectre").setup({
        -- your config overrides, or just omit for defaults
      })
      -- example keymap
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
    end,
  },

  -- other plugins …
}

