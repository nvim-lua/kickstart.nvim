-- Java Language Server configuration.
-- Locations:
-- 'nvim/ftplugin/java.lua'.
-- 'nvim/lang-servers/intellij-java-google-style.xml'

-- local jdtls_ok, jdtls = pcall(require, 'jdtls')
-- if not jdtls_ok then
--   vim.notify 'JDTLS not found, install with `:LspInstall jdtls`'
--   return
-- end

local home = os.getenv 'HOME'
local jdtls = require 'jdtls'
-- vim.notify 'Home: ' .. home

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'
local path_to_lsp_server = jdtls_path .. '/config_mac'
local path_to_plugins = jdtls_path .. '/plugins/'
local path_to_jar = path_to_plugins .. 'org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
local lombok_path = jdtls_path .. '/lombok.jar'
local styling = home .. '/.local/share/java/eclipse-java-google-style.xml'
print(lombok_path)

local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. project_name
os.execute('mkdir ' .. workspace_dir)

local java_21_home_dir = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home'
local java_17_home_dir = '/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home'
local java_11_home_dir = '/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home'

-- Main Config
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    java_21_home_dir .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Xmx1g',
    '-Dlog.level=ALL',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    path_to_jar,
    '-configuration',
    path_to_lsp_server,
    '-data',
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = root_dir,

  settings = {
    java = {
      home = java_21_home_dir,
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-21',
            path = java_21_home_dir,
          },
          {
            name = 'JavaSE-11',
            path = java_11_home_dir,
          },
          {
            name = 'JavaSE-17',
            path = java_17_home_dir,
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        settings = {
          url = styling,
          profile = 'GoogleStyle',
        },
      },
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
      },
      importOrder = {
        'java',
        'com',
        'org',
        'javax',
        'jarkata',
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {
      vim.fn.glob(lombok_path, 1),
    },
  },
}

-- config['on_attach'] = function(_, bufnr)
--   require('keymaps').map_java_keys(bufnr)
--   require('lsp_signature').on_attach({
--     bind = true, -- This is mandatory, otherwise border config won't get registered.
--     floating_window_above_cur_line = false,
--     padding = '',
--     handler_opts = {
--       border = 'rounded',
--     },
--   }, bufnr)
-- end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
