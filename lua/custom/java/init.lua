return {
  'nvim-java/nvim-java',
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      config = false,
      opts = {
        servers = {
          jdtls = {},
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require('java').setup {
              'settings.gradle',
              'settings.gradle.kts',
              'pom.xml',
              'build.gradle',
              'mvnw',
              'gradlew',
              'build.gradle',
              'build.gradle.kts',
            }
          end,
        },
      },
    },
  },
}
