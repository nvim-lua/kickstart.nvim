local M = {}

-- local Path = require 'plenary.path'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values

local current_target = './build/debug'

local function make_clangd_cmd()
  return {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--query-driver=' .. vim.fn.exepath 'clang++',
    '--resource-dir=' .. vim.fn.trim(vim.fn.system 'clang++ --print-resource-dir'),
    '--compile-commands-dir=' .. current_target,
  }
end

local function reload_clangd()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == 'clangd' then
      client.stop()
    end
  end
  M.setup()
end

function M.pick_target()
  pickers
    .new({}, {
      prompt_title = 'Choose build target',
      finder = finders.new_oneshot_job { 'fd', '-u', 'compile_commands.json', '-x', 'dirname', '{}' },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = require('telescope.actions.state').get_selected_entry()
          current_target = entry[1]
          require('telescope.actions').close(prompt_bufnr)
          reload_clangd()
        end)
        return true
      end,
    })
    :find()
end

function M.setup()
  local lspconfig = require 'lspconfig'
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  lspconfig.clangd.setup {
    cmd = make_clangd_cmd(),
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_dir = lspconfig.util.root_pattern '.git',
    single_file_support = true,
    capabilities = capabilities,
  }
end

M.setup()

return {}
