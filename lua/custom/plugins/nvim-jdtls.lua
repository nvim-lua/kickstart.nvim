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
      local equinox_launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      -- local equinox = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"

      local java_test_pkg = mason_registry.get_package("java-test")
      local java_test_path = java_test_pkg:get_install_path()

      local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
      local java_dbg_path = java_dbg_pkg:get_install_path()

      local vscode_java_test_path = home .. "/.config/nvim/vscode-java-test"

      local jar_patterns = {
        java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        -- enable java test, and disable vscode_java_test when version of com.microsoft.java.test.plugin-*.jar is 0.40.0 or higher
        -- java_test_path .. "/extension/server/*.jar",
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
          references = {
            includeDecompiledSources = true,
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            }
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/lang_servers/nykredit-java-style.xml",
              profile = "Nykredit",
            },
          },
          autobuild = {
            enabled = true
          },
          maven = {
            downloadSources = true,
          },
          rename = {
            enabled = true
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
            updateBuildConfiguration = "interactive",
            maven = {
              userSettings = nil,
            },
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
          },
          project = {
          },
        },
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
      capabilities.workspace = {
        configuration = true
      }

      local on_attach = function(client, buffer)
        vim.opt.omnifunc = 'v:v:lua.vim.lsp.omnifunc'

        require("jdtls").setup_dap({ config_overrides = {}, hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
        require('lsp.keymap').on_attach(client, buffer)

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

        vim.keymap.set("n", "<leader>gt", function() require('jdtls.tests').goto_subjects() end,
          { buffer = buffer, desc = "LSP: [G]o to [T]est class" })

        -- NOTE: Java specific keymaps with which key
        vim.cmd(
          "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
        )
        vim.cmd(
          "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
        )
        vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
        vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
        vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
        vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

        -- Highlighter for variables and such
        vim.cmd([[
               " hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkGrey
               " hi LspReferenceText cterm=bold ctermbg=red guibg=DarkGrey
               " hi LspReferenceWrite cterm=bold ctermbg=red guibg=DarkGrey
               augroup LspHighlight
               autocmd!
               autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
               autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
               augroup END
        ]])
      end

      -- get the mason install path
      local config = {
        init_options = {
          bundles = bundles,
          extendedClientCapabilities = extendedClientCapabilities,
        },

        -- cmd = {
        --   --
        --   -- 				-- ??
        --   "/usr/lib/jvm/java-17-openjdk-amd64/bin/java", -- or '/path/to/java17_or_newer/bin/java'
        --   -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        --
        --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        --   "-Dosgi.bundles.defaultStartLevel=4",
        --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
        --   "-Dlog.protocol=true",
        --   "-Dlog.level=ALL",
        --   "-Xmx1g",
        --   "-javaagent:" .. jdtls_path .. "/lombok.jar",
        --   "--add-modules=ALL-SYSTEM",
        --   "--add-opens", "java.base/java.util=ALL-UNNAMED",
        --   "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED",
        --   "--add-opens", "jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED",
        --
        --   -- ??
        --   "-jar",
        --   equinox_launcher,
        --   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        --   -- Must point to the                                                     Change this to
        --   -- eclipse.jdt.ls installation                                           the actual version
        --
        --   -- ??
        --   "-configuration",
        --   jdtls_path .. "/config_linux",
        --   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        --   -- Must point to the                      Change to one of `linux`, `win` or `mac`
        --   -- eclipse.jdt.ls installation            Depending on your system.
        --
        --   -- See `data directory configuration` section in the README
        --   "-data",
        --   workspace_folder,
        -- },
        cmd = {
          jdtls_bin,
          "--jvm-arg=-javaagent:" .. jdtls_path .. "/lombok.jar",
          "--jvm-arg=-Dlog.level=ALL",
          -- "--jvm-arg=--add-opens jdk.compiler/com.sun.javac.tree=ALL-UNNAMED",
          "-data",
          workspace_folder,
        },
        -- -- attach general lsp 'on_attach function'
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
