---@diagnostic disable: undefined-global
-- Keymaps init - loads all keymap modules

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local M = {}

-- Import keymap modules
local core = require('core.keymaps.core')
local lsp = require('core.keymaps.lsp')
local telescope = require('core.keymaps.telescope')
local diagnostic = require('core.keymaps.diagnostic')
local git = require('core.keymaps.git')
local plugins = require('core.keymaps.plugins')

-- Export for external use
M.setup_lsp_keymaps = lsp.setup
M.telescope_keymaps = telescope
M.diagnostic_keymaps = diagnostic
M.gitsigns_keymaps = git.keymaps
M.dadbod_keymaps = plugins.dadbod
M.session_keymaps = plugins.session
M.scratch_keymaps = plugins.scratch
M.snacks_keymaps = plugins.snacks
M.leap_keymaps = plugins.leap
M.elixir_keymaps = plugins.elixir
M.mini_surround_keymaps = plugins.mini_surround

-- Setup functions
M.setup_gitsigns_keymaps = git.setup
M.setup_dadbod_keymaps = plugins.setup_dadbod
M.setup_session_keymaps = plugins.setup_session
M.setup_elixir_keymaps = plugins.setup_elixir
M.setup_leap_keymaps = plugins.setup_leap

-- Default on_attach for LSP (used by lsp/setup.lua)
M.default_on_attach = nil

local explorer_keymaps_set = false
local function setup_explorer_keymaps()
  if explorer_keymaps_set then return end
  explorer_keymaps_set = true

  for _, key in ipairs({ '<leader>e', '<leader>E' }) do
    pcall(vim.keymap.del, 'n', key)
  end

  for _, mapping in ipairs(plugins.snacks) do
    if mapping.lhs == '<leader>e' or mapping.lhs == '<leader>E' then
      vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, vim.tbl_extend('force', mapping.opts, {
        replace_keycodes = false,
        nowait = true,
        silent = true,
      }))
    end
  end
end

local function init_keymaps()
  local keymap_group = vim.api.nvim_create_augroup('custom_keymaps', { clear = true })

  -- Handle snacks explorer during buffer writes
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = keymap_group,
    callback = function()
      pcall(function()
        local picker = require('plugins.snacks.picker')
        if picker.is_open() then
          picker.pause_updates()
          vim.schedule(function() picker.resume_updates() end)
        end
      end)
    end,
  })

  -- Set up autocmds to maintain explorer keymaps
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter' }, {
    group = keymap_group,
    callback = setup_explorer_keymaps,
  })

  -- Set up LSP keymaps on attach
  vim.api.nvim_create_autocmd('LspAttach', {
    group = keymap_group,
    callback = function(args) M.setup_lsp_keymaps(args.buf) end,
  })

  -- Core keymaps
  for _, mapping in ipairs(core) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Telescope keymaps
  for _, mapping in ipairs(telescope) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Diagnostic keymaps
  for _, mapping in ipairs(diagnostic) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Plugin keymaps
  plugins.setup_snacks()
  plugins.setup_scratch()
  plugins.setup_dadbod()
  plugins.setup_session()
  plugins.setup_leap()
  plugins.setup_elixir()
  git.setup()

  -- Tab navigation
  vim.keymap.set('n', 'gt', ':tabnext<CR>', { silent = true, desc = 'Next tab' })
  vim.keymap.set('n', 'gT', ':tabprevious<CR>', { silent = true, desc = 'Previous tab' })
end

init_keymaps()

M.setup = init_keymaps

return M
