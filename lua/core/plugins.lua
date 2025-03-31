local conform = require 'plugin-configs.conform'
local dapUi = require 'plugin-configs.dap-ui'
local fuzzyFinder = require 'plugin-configs.fuzzy-finder'
local gitsigns = require 'plugin-configs.gitsigns'
local lazyDev = require 'plugin-configs.lazy-dev'
local lspConfig = require 'plugin-configs.lsp-config'
local luvitMeta = require 'plugin-configs.luvit-meta'
local miniNvim = require 'plugin-configs.mini-nvim'
local nvimCmp = require 'plugin-configs.nvim-cmp'
local nvimDap = require 'plugin-configs.nvim-dap'
local obsidian = require 'plugin-configs.obsidian'
local oil = require 'plugin-configs.oil'
local todoComments = require 'plugin-configs.todo-comments'
local tokyoNight = require 'plugin-configs.tokyo-night'
local treesitter = require 'plugin-configs.treesitter'
local whichKey = require 'plugin-configs.which-key'

--return {
--  'stevearc/oil.nvim',
--
--  -- Optional dependencies
--  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
--  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
--  { 'lewis6991/gitsigns.nvim', opts = 'plugin-configurations.gitsigns' },
--  { 'folke/which-key.nvim', whichKeyConfig },
--} --
return {
  conform,
  dapUi,
  fuzzyFinder,
  gitsigns,
  lazyDev,
  lspConfig,
  luvitMeta,
  miniNvim,
  nvimCmp,
  nvimDap,
  obsidian,
  oil,
  todoComments,
  tokyoNight,
  treesitter,
  whichKey,
}
