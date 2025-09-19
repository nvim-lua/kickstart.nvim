-- print 'Loaded ftplugin/java.lua'
local jdtls = require 'jdtls'

local root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml' }
if root_dir == '' then
  root_dir = vim.fn.getcwd()
end

print('JDTLS root_dir = ' .. root_dir)

local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local config = {
  cmd = { vim.fn.stdpath 'data' .. '/mason/packages/jdtls/bin/jdtls' }, -- 👈 absolute path
  root_dir = root_dir,
  workspace_folder = workspace_dir,
  settings = {
    java = {
      project = {
        sourcePaths = { 'src' }, -- 👈 tells jdtls where sources begin
      },
    },
  },
}

jdtls.start_or_attach(config)
