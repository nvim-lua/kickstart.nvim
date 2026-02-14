-- ftplugin/java.lua
-- This file is automatically loaded when a Java file is opened.
-- It configures jdtls (Eclipse JDT Language Server) for Java development.

local jdtls = require 'jdtls'

-- Mason install paths
local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'
local jdtls_path = mason_path .. '/jdtls'
local java_debug_path = mason_path .. '/java-debug-adapter'
local java_test_path = mason_path .. '/java-test'

-- Detect the OS for the jdtls config directory
local os_config = 'config_linux'
if vim.fn.has 'mac' == 1 then
  os_config = 'config_mac'
elseif vim.fn.has 'win32' == 1 then
  os_config = 'config_win'
end

-- Find the launcher jar
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Determine the project name for workspace isolation
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

-- Find the root directory of the project
local root_dir = require('jdtls.setup').find_root { 'pom.xml', 'build.gradle', 'gradlew', '.git', 'mvnw' }

-- Collect debug and test bundles
local bundles = {}

-- java-debug-adapter
local debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
if debug_jar ~= '' then
  table.insert(bundles, debug_jar)
end

-- java-test
local test_jars = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n')
for _, jar in ipairs(test_jars) do
  if jar ~= '' then
    table.insert(bundles, jar)
  end
end

-- jdtls configuration
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher_jar,
    '-configuration', jdtls_path .. '/' .. os_config,
    '-data', workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
          'org.mockito.ArgumentMatchers.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },

  -- Called when jdtls attaches to a buffer
  on_attach = function(_, bufnr)
    -- Enable debug and test support after LSP is ready
    jdtls.setup_dap { hotcodereplace = 'auto' }
    require('jdtls.dap').setup_dap_main_class_configs()

    local opts = { buffer = bufnr }

    -- Java-specific keymaps under <leader>j
    vim.keymap.set('n', '<leader>ji', jdtls.organize_imports, vim.tbl_extend('force', opts, { desc = '[J]ava Organize [I]mports' }))
    vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, vim.tbl_extend('force', opts, { desc = '[J]ava Extract [C]onstant' }))
    vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end, vim.tbl_extend('force', opts, { desc = '[J]ava Extract [M]ethod' }))
    vim.keymap.set('v', '<leader>jv', jdtls.extract_variable, vim.tbl_extend('force', opts, { desc = '[J]ava Extract [V]ariable' }))

    -- Test keymaps using neotest
    local neotest = require 'neotest'
    vim.keymap.set('n', '<leader>jt', function() neotest.run.run() end, vim.tbl_extend('force', opts, { desc = '[J]ava Run [T]est (cursor)' }))
    vim.keymap.set('n', '<leader>jf', function() neotest.run.run(vim.fn.expand '%') end, vim.tbl_extend('force', opts, { desc = '[J]ava Run Tests [F]ile' }))
    vim.keymap.set('n', '<leader>js', function() neotest.summary.toggle() end, vim.tbl_extend('force', opts, { desc = '[J]ava Test [S]ummary' }))
    vim.keymap.set('n', '<leader>jo', function() neotest.output.open { enter = true } end, vim.tbl_extend('force', opts, { desc = '[J]ava Test [O]utput' }))

    -- Debug test under cursor
    vim.keymap.set('n', '<leader>jd', function() neotest.run.run { strategy = 'dap' } end, vim.tbl_extend('force', opts, { desc = '[J]ava [D]ebug Test' }))
  end,
}

-- Start or attach jdtls
jdtls.start_or_attach(config)
