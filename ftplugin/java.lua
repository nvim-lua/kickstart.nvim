local root_markers = { 'gradlew', 'pom.xml' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv 'HOME'

local workspace_folder = home .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
local config = {}

config.cmd = {
  '/Users/joshua/.jabba/jdk/amazon-corretto@1.17.0-0.35.1/Contents/Home/bin/java',
  '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
  '-javaagent:/Users/joshua/.config/jdtls/jars/lombok.jar',

  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens',
  'java.base/java.util=ALL-UNNAMED',
  '--add-opens',
  'java.base/java.lang=ALL-UNNAMED',
  '-jar',
  '/Users/joshua/.config/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
  '-configuration',
  '/Users/joshua/.config/jdtls/config_mac',

  '-data',
  workspace_folder,
}

-- Server
require('jdtls').start_or_attach(config)
