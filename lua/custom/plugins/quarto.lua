return {
  {
    'quarto-dev/quarto-nvim',
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = 'curly',
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  {
    'jpalardy/vim-slime',
    dev = false,
    init = function()
      vim.g.slime_target = 'tmux'
      -- vim.g.slime_default_config = {"socket_name" = "default", "target_pane" = "{last}"}
      vim.g.slime_default_config = {
        -- Lua doesn't have a string split function!
        socket_name = vim.api.nvim_eval 'get(split($TMUX, ","), 0)',
        target_pane = '{bottom}',
      }
    end,
  },
}
