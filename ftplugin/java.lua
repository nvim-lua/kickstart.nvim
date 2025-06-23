local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify('JDTLS not found, install with `:MasonInstall jdtls`', vim.log.levels.ERROR)
  return
end

-- Path setup
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local path_to_lsp_server = jdtls_path .. '/config_mac'
local path_to_plugins = jdtls_path .. '/plugins/'
local path_to_jar = vim.fn.glob(path_to_plugins .. 'org.eclipse.equinox.launcher_*.jar')
local lombok_path = vim.fn.glob(path_to_plugins .. 'lombok.jar')

-- Debug: Print paths
-- print("JDTLS Path: " .. jdtls_path)
-- print("LSP Server Path: " .. path_to_lsp_server)
-- print("JAR Path: " .. path_to_jar)
-- print("Lombok Path: " .. lombok_path)

-- Check if paths exist
if vim.fn.executable(vim.fn.glob('/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/bin/java')) == 0 then
  vim.notify('Java 17 not found at expected path', vim.log.levels.ERROR)
  return
end

if path_to_jar == '' then
  vim.notify('JDTLS JAR not found', vim.log.levels.ERROR)
  return
end

-- Java home directories
local java_17_home = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home'

-- Root directory detection
local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
if root_dir == '' then 
  print("No root directory found")
  return 
end

-- print("Root directory: " .. root_dir)

-- Workspace setup
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
vim.fn.mkdir(workspace_dir, 'p')

-- print("Workspace directory: " .. workspace_dir)

-- Main Config
local config = {
  cmd = {
    java_17_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',  -- Changed back to ALL for debugging
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    '-jar', path_to_jar,
    '-configuration', path_to_lsp_server,
    '-data', workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          { name = 'JavaSE-17', path = java_17_home, default = true }
        }
      }
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      }
    }
  },

  flags = { allow_incremental_sync = true },
  init_options = { bundles = {} }
}

-- Keymaps setup
config.on_attach = function(_, bufnr)
  vim.notify('JDTLS attached to buffer ' .. bufnr, vim.log.levels.INFO)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
end

-- Debug: Print config command
-- print("JDTLS Command: " .. table.concat(config.cmd, ' '))
--
-- -- Start JDTLS
-- print("Starting JDTLS...")
jdtls.start_or_attach(config)
