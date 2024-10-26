local java_21_home_dir = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/bin/java'

require('java').setup()
require('lspconfig').jdtls.setup {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = java_21_home_dir .. '/bin/java',
            default = true,
          },
        },
      },
    },
  },
}
