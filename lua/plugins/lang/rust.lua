-- Rust Development Configuration
-- Loaded only for Rust files (*.rs)

return {
  -- Rust Tools - Enhanced rust-analyzer integration
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false, -- Already lazy-loaded by filetype
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          -- Register which-key group for Rust
          require('which-key').add {
            { '<leader>r', group = '󱘗 rust', buffer = bufnr },
          }

          -- Hover actions
          vim.keymap.set('n', '<leader>rh', function()
            vim.cmd.RustLsp { 'hover', 'actions' }
          end, { buffer = bufnr, desc = 'Hover actions' })

          -- Code actions
          vim.keymap.set('n', '<leader>ra', function()
            vim.cmd.RustLsp('codeAction')
          end, { buffer = bufnr, desc = 'Code actions' })

          -- Explain error
          vim.keymap.set('n', '<leader>re', function()
            vim.cmd.RustLsp('explainError')
          end, { buffer = bufnr, desc = 'Explain error' })

          -- Open Cargo.toml
          vim.keymap.set('n', '<leader>rC', function()
            vim.cmd.RustLsp('openCargo')
          end, { buffer = bufnr, desc = 'Open Cargo.toml' })

          -- Parent module
          vim.keymap.set('n', '<leader>rp', function()
            vim.cmd.RustLsp('parentModule')
          end, { buffer = bufnr, desc = 'Parent module' })

          -- Join lines
          vim.keymap.set('n', '<leader>rj', function()
            vim.cmd.RustLsp('joinLines')
          end, { buffer = bufnr, desc = 'Join lines' })

          -- Runnables
          vim.keymap.set('n', '<leader>rr', function()
            vim.cmd.RustLsp('runnables')
          end, { buffer = bufnr, desc = 'Runnables' })

          -- Debuggables
          vim.keymap.set('n', '<leader>rd', function()
            vim.cmd.RustLsp('debuggables')
          end, { buffer = bufnr, desc = 'Debuggables' })

          -- Expand macro
          vim.keymap.set('n', '<leader>rm', function()
            vim.cmd.RustLsp('expandMacro')
          end, { buffer = bufnr, desc = 'Expand macro' })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust
            checkOnSave = {
              allFeatures = true,
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
      -- DAP configuration
      dap = {
        adapter = {
          type = 'executable',
          command = 'lldb-vscode', -- or 'lldb-dap' on newer versions
          name = 'lldb',
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- Crates.io integration
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)

      -- Crates keymaps (only in Cargo.toml)
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = 'Cargo.toml',
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()

          -- Register which-key group for Rust Crates
          require('which-key').add {
            { '<leader>rc', group = ' crates', buffer = bufnr },
          }

          vim.keymap.set('n', '<leader>rct', function()
            crates.toggle()
          end, { buffer = bufnr, desc = 'Toggle crates' })

          vim.keymap.set('n', '<leader>rcr', function()
            crates.reload()
          end, { buffer = bufnr, desc = 'Reload crates' })

          vim.keymap.set('n', '<leader>rcv', function()
            crates.show_versions_popup()
          end, { buffer = bufnr, desc = 'Show versions' })

          vim.keymap.set('n', '<leader>rcf', function()
            crates.show_features_popup()
          end, { buffer = bufnr, desc = 'Show features' })

          vim.keymap.set('n', '<leader>rcd', function()
            crates.show_dependencies_popup()
          end, { buffer = bufnr, desc = 'Show dependencies' })

          vim.keymap.set('n', '<leader>rcu', function()
            crates.update_crate()
          end, { buffer = bufnr, desc = 'Update crate' })

          vim.keymap.set('v', '<leader>rcu', function()
            crates.update_crates()
          end, { buffer = bufnr, desc = 'Update selected' })

          vim.keymap.set('n', '<leader>rca', function()
            crates.update_all_crates()
          end, { buffer = bufnr, desc = 'Update all' })

          vim.keymap.set('n', '<leader>rcU', function()
            crates.upgrade_crate()
          end, { buffer = bufnr, desc = 'Upgrade crate' })

          vim.keymap.set('v', '<leader>rcU', function()
            crates.upgrade_crates()
          end, { buffer = bufnr, desc = 'Upgrade selected' })

          vim.keymap.set('n', '<leader>rcA', function()
            crates.upgrade_all_crates()
          end, { buffer = bufnr, desc = 'Upgrade all' })

          vim.keymap.set('n', '<leader>rce', function()
            crates.expand_plain_crate_to_inline_table()
          end, { buffer = bufnr, desc = 'Expand to inline' })

          vim.keymap.set('n', '<leader>rcE', function()
            crates.extract_crate_into_table()
          end, { buffer = bufnr, desc = 'Extract to table' })

          vim.keymap.set('n', '<leader>rcH', function()
            crates.open_homepage()
          end, { buffer = bufnr, desc = 'Open homepage' })

          vim.keymap.set('n', '<leader>rcR', function()
            crates.open_repository()
          end, { buffer = bufnr, desc = 'Open repository' })

          vim.keymap.set('n', '<leader>rcD', function()
            crates.open_documentation()
          end, { buffer = bufnr, desc = 'Open documentation' })

          vim.keymap.set('n', '<leader>rcC', function()
            crates.open_crates_io()
          end, { buffer = bufnr, desc = 'Open crates.io' })
        end,
      })
    end,
  },

  -- Mason tool installations for Rust
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'rust-analyzer',
        'codelldb', -- For debugging
      })
    end,
  },

  -- Treesitter for Rust
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'rust',
        'ron', -- Rusty Object Notation
        'toml', -- For Cargo.toml
      })
    end,
  },

  -- DAP configuration for Rust
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      local dap = require 'dap'
      
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
        {
          name = 'Attach to process',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
        },
      }

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.exepath 'codelldb',
          args = { '--port', '${port}' },
        },
      }
    end,
  },
}
