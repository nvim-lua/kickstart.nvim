-- Java LSP configuration using nvim-jdtls
-- This provides better Java support including auto-imports, code actions, etc.
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  config = function()
    -- This function will be called when a Java file is opened
    local function setup_jdtls()
      local jdtls = require("jdtls")

      -- Find the Mason installation path
      local mason_registry = require("mason-registry")
      local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()

      -- Find the appropriate jar file (the launcher)
      local jar_patterns = {
        jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar",
      }

      local jar_path = nil
      for _, pattern in ipairs(jar_patterns) do
        local matches = vim.fn.glob(pattern, true, true)
        if #matches > 0 then
          jar_path = matches[1]
          break
        end
      end

      if not jar_path then
        vim.notify("Could not find JDTLS launcher jar", vim.log.levels.ERROR)
        return
      end

      -- Determine the OS-specific configuration
      local os_config = "linux"
      if vim.fn.has("mac") == 1 then
        os_config = "mac"
      elseif vim.fn.has("win32") == 1 then
        os_config = "win"
      end

      -- Data directory for this workspace
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

      -- Get the Java debug adapter bundles
      local bundles = {}
      local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()

      -- Add java-debug adapter (required for debugging)
      vim.list_extend(bundles, vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true))

      -- NOTE: java-test bundles disabled due to org.objectweb.asm dependency conflict
      -- To run tests, use: mvn test or gradle test from command line
      -- local java_test_path = mason_registry.get_package("java-test"):get_install_path()
      -- vim.list_extend(bundles, vim.fn.glob(java_test_path .. "/extension/server/*.jar", true, true))

      -- Find Lombok jar
      local lombok_path = jdtls_path .. "/lombok.jar"

      -- LSP settings for Java
      local extendedClientCapabilities = jdtls.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      -- Build cmd array with Lombok support
      local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      }

      -- Add Lombok agent if jar exists
      if vim.fn.filereadable(lombok_path) == 1 then
        table.insert(cmd, "-javaagent:" .. lombok_path)
      end

      -- Add jar and configuration
      table.insert(cmd, "-jar")
      table.insert(cmd, jar_path)
      table.insert(cmd, "-configuration")
      table.insert(cmd, jdtls_path .. "/config_" .. os_config)
      table.insert(cmd, "-data")
      table.insert(cmd, workspace_dir)

      local config = {
        cmd = cmd,

        root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),

        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
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
              enabled = true,
            },
            -- Enable auto-import completion
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.Assert.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
              },
              importOrder = {
                "java",
                "javax",
                "com",
                "org",
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
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
          },
          signatureHelp = { enabled = true },
          extendedClientCapabilities = extendedClientCapabilities,
        },

        init_options = {
          bundles = bundles,
        },

        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- JDTLS-specific keybindings
          local opts = { buffer = bufnr, noremap = true, silent = true }

          -- Organize imports
          vim.keymap.set("n", "<leader>co", function()
            require("jdtls").organize_imports()
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode [O]rganize Imports" }))

          -- Extract variable
          vim.keymap.set("n", "<leader>cv", function()
            require("jdtls").extract_variable()
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode Extract [V]ariable" }))

          vim.keymap.set("v", "<leader>cv", function()
            require("jdtls").extract_variable(true)
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode Extract [V]ariable" }))

          -- Extract constant
          vim.keymap.set("n", "<leader>cc", function()
            require("jdtls").extract_constant()
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode Extract [C]onstant" }))

          vim.keymap.set("v", "<leader>cc", function()
            require("jdtls").extract_constant(true)
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode Extract [C]onstant" }))

          -- Extract method
          vim.keymap.set("v", "<leader>cm", function()
            require("jdtls").extract_method(true)
          end, vim.tbl_extend("force", opts, { desc = "LSP: [C]ode Extract [M]ethod" }))

          -- Test class/method (disabled - java-test bundles not loaded)
          -- Use command line instead: mvn test -Dtest=ClassName or mvn test -Dtest=ClassName#methodName
          -- vim.keymap.set("n", "<leader>tn", function()
          --   require("jdtls").test_nearest_method()
          -- end, vim.tbl_extend("force", opts, { desc = "LSP: [T]est [N]earest Method" }))
          --
          -- vim.keymap.set("n", "<leader>tc", function()
          --   require("jdtls").test_class()
          -- end, vim.tbl_extend("force", opts, { desc = "LSP: [T]est [C]lass" }))

          -- DAP setup
          jdtls.setup_dap({ hotcodereplace = "auto" })
          require("jdtls.dap").setup_dap_main_class_configs()
        end,
      }

      -- Start or attach to the language server
      jdtls.start_or_attach(config)
    end

    -- Set up an autocommand to start JDTLS when opening Java files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = setup_jdtls,
    })
  end,
}
