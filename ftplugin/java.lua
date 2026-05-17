---- print 'Loaded ftplugin/java.lua'
--local jdtls = require 'jdtls'
--
--local root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', '.project' }
--if root_dir == '' then
--  root_dir = vim.fn.getcwd()
--end
--
---- print('JDTLS root_dir = ' .. root_dir)
--
--local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
--
--local config = {
--  cmd = { vim.fn.stdpath 'data' .. '/mason/packages/jdtls/bin/jdtls' },
--  root_dir = root_dir,
--  workspace_folder = workspace_dir,
--  settings = {
--    java = {
--      project = {
--        sourcePaths = { 'src' },
--      },
--    },
--  },
--}
--
--jdtls.start_or_attach(config)
local jdtls = require 'jdtls'

local root_dir = require('jdtls.setup').find_root { '.git', 'pom.xml', '.project', 'build.gradle' }
if root_dir == '' then
  root_dir = vim.fn.getcwd()
end

local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local config = {
  cmd = {
    vim.fn.stdpath 'data' .. '/mason/packages/jdtls/bin/jdtls',
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
}

jdtls.start_or_attach(config)

-- LSP keymaps (for rename, code actions, etc.)
local opts = { buffer = true }
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP: Rename' }))
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP: Code Action' }))
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' }))
vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: Find References' }))
vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Hover Doc' }))
