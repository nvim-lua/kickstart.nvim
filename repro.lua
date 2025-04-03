-- Run with `nvim -u repro.lua`

vim.env.LAZY_STDPATH = '.repro'
load(vim.fn.system 'curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua')()

---@diagnostic disable-next-line: missing-fields
require('lazy.minit').repro {
  spec = {
    {
      'saghen/blink.cmp',
      -- please test on `main` if possible
      -- otherwise, remove this line and set `version = '*'`
      build = 'cargo build --release',
      opts = {},
    },
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          lua_ls = {},
          gdscript = {
            cmd = { 'ncat', '127.0.0.1', '6005' },
            name = 'godot',
          },
        },
      },
      config = function(_, opts)
        local lspconfig = require 'lspconfig'
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities()
          lspconfig[server].setup(config)
        end
      end,
    },
  },
}
