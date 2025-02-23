return {
  -- Go development
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Gopls configuration
        lsp_cfg = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
              usePlaceholders = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        -- Format on save
        gofmt = "gofumpt",
        -- Import on save
        goimports = true,
        -- Enable linters
        linter = "golangci-lint",
        -- Test settings
        test_runner = "go",
        test_flags = {"-v"},
        -- Debug settings
        dap_debug = true,
        dap_debug_gui = true,
      })

      -- Run gofmt + goimports on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Zig development
  {
    "ziglang/zig.vim",
    ft = "zig",
    config = function()
      -- Enable auto-formatting on save
      vim.g.zig_fmt_autosave = 1
    end,
  },

  -- C development
  {
    "p00f/clangd_extensions.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = "🄣",
          declaration = "🄓",
          expression = "🄔",
          statement = ";",
          specifier = "🄢",
          ["template argument"] = "🆃",
        },
        kind_icons = {
          Compound = "🄲",
          Recovery = "🅁",
          TranslationUnit = "🅄",
          PackExpansion = "🄿",
          TemplateTypeParm = "🅃",
          TemplateTemplateParm = "🅃",
          TemplateParamObject = "🅃",
        },
      },
    },
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go", -- Go debug adapter
      "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Set up Go debugging
      require("dap-go").setup()

      -- Set up Python debugging
      dap.adapters.python = {
        type = 'executable',
        command = 'debugpy-adapter',
      }

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Try to detect python path from active virtual environment
            if vim.env.VIRTUAL_ENV then
              return vim.env.VIRTUAL_ENV .. "/bin/python"
            end
            -- Return system python if no venv
            return '/usr/bin/python3'
          end,
        },
      }

      -- Set up C debugging with codelldb
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = 'codelldb',
          args = {"--port", "${port}"},
        }
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- Set up UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10
          },
        },
      })

      -- Automatically open UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Add keymaps
      vim.keymap.set("n", "<leader>pb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>pc", dap.continue, { desc = "Continue Debug" })
      vim.keymap.set("n", "<leader>pn", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>pi", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>po", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>pr", dap.repl.open, { desc = "Debug REPL" })
      vim.keymap.set("n", "<leader>pl", dap.run_last, { desc = "Run Last Debug" })
      vim.keymap.set("n", "<leader>px", dapui.toggle, { desc = "Toggle Debug UI" })

      -- Profiling commands
      local function profile_go()
        local file = vim.fn.expand('%:p')
        local cmd = string.format('go test -cpuprofile cpu.prof -memprofile mem.prof -bench . %s', file)
        vim.fn.system(cmd)
        vim.cmd('split term://go tool pprof -http=:8080 cpu.prof')
      end

      local function profile_python()
        local file = vim.fn.expand('%:p')
        local cmd = string.format('py-spy record -o profile.svg -f speedscope -- python %s', file)
        vim.fn.system(cmd)
        vim.cmd('!xdg-open profile.svg')
      end

      local function profile_c()
        local file = vim.fn.expand('%:p:r')  -- Get file path without extension
        local cmd = string.format('perf record -g ./%s && perf report -g graph', file)
        vim.cmd('split term://' .. cmd)
      end

      -- Add profiling keymaps based on filetype
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "python", "c", "cpp" },
        callback = function()
          local ft = vim.bo.filetype
          if ft == "go" then
            vim.keymap.set("n", "<leader>mp", profile_go, { buffer = true, desc = "Profile Go code" })
          elseif ft == "python" then
            vim.keymap.set("n", "<leader>mp", profile_python, { buffer = true, desc = "Profile Python code" })
          elseif ft == "c" or ft == "cpp" then
            vim.keymap.set("n", "<leader>mp", profile_c, { buffer = true, desc = "Profile C/C++ code" })
          end
        end,
      })
    end,
  },
}
