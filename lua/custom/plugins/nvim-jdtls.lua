return {

  -- correctly setup mason lsp / dap extensions
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {"jdtls", "java-test", "java-debug-adapter" })
  --   end,
  -- },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local home = os.getenv('HOME')
      local mason_registry = require("mason-registry")
      local jdtls_pkg = mason_registry.get_package("jdtls")
      local jdtls_path = jdtls_pkg:get_install_path()
      local jdtls_bin = jdtls_path .. "/bin/jdtls"

      local java_test_pkg = mason_registry.get_package("java-test")
      local java_test_path = java_test_pkg:get_install_path()

      local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
      local java_dbg_path = java_dbg_pkg:get_install_path()

      local vscode_java_test_path = home .. "/.config/nvim/vscode-java-test"

      local jar_patterns = {
        java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        java_test_path .. "/extension/server/*.jar",
        vscode_java_test_path .. "/*.jar"
      }

      local bundles = {}
      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), '\n')) do
          table.insert(bundles, bundle)
        end
      end

      local settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*"
            }
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            }
          },
          maven = {
            downloadSources = true,
          },
          import = {
            maven = {
              enabled = true,
            },
          },
          inlayHints = {
            parameterNames = {
              enabled = "all", -- literals, all, none
            },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-1.8",
                path = "/usr/lib/jvm/java-8-openjdk-amd64",
              },
              {
                name = "JavaSE-11",
                path = "/usr/lib/jvm/java-11-openjdk-amd64",
                default = true,
              },
              {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk-amd64",
              },
              -- {
              --   name = "JavaSE-19",
              --   path = "/usr/lib/jvm/java-19-openjdk-amd64",
              -- },
            }
          }
        }
      }

      local function print_test_results(items)
        if #items > 0 then
          vim.cmd([[Trouble quickfix]])
        else
          vim.cmd([[TroubleClose quickfix]])
        end
      end

      local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
      extendedClientCapabilities.progressReportProvider = false


      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      -- calculate workspace dir
      local workspace_folder = home .. "/.cache/jdtls/workspace/" .. project_name

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, buffer)
        require('lsp.keymap').on_attach(_, buffer)

        -- custom keymaps
        vim.keymap.set("n", "<leader>co", function() require("jdtls").organize_imports() end,
          { buffer = buffer, desc = "LSP: Organize Imports" })


        vim.keymap.set('n', '<leader>ct', function() require('jdtls').test_class() end,
          { buffer = buffer, desc = 'LSP: Run test class' })

        vim.keymap.set('n', '<leader>cn', function() require('jdtls').test_nearest_method() end,
          { buffer = buffer, desc = 'LSP: Run nerest test method' })

        vim.keymap.set("n", "<leader>cs",
          function() require("jdtls").pick_test({ bufnr = buffer, after_test = print_test_results }) end,
          { buffer = buffer, desc = "LSP: Run Single Test" })

        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
      end

      -- get the mason install path
      local config = {
        init_options = {
          bundles = bundles,
          extendedClientCapabilities = extendedClientCapabilities,
        },
        cmd = {
          jdtls_bin,
          "--jvm-arg=-javaagent:" .. jdtls_path .. "/lombok.jar",
          "-data",
          workspace_folder,
        },
        -- attach general lsp 'on_attach function'
        -- on_attach = require("lsp.keymap").on_attach,
        on_attach = on_attach,
        capabilities = capabilities,
        -- we naively believe that the whole project is versioned through git, and therefore
        root_dir = vim.fs.dirname(
          vim.fs.find({ ".git" }, { upward = true })[1]
        ),
        settings = settings,
        flags = {
          allow_incremental_sync = true,
        },
        on_init = function(client, _)
          client.notify('workspace/didChangeConfiguration', { settings = settings })
        end,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          require("jdtls").start_or_attach(config)
        end,
      })
    end,
  }
}
