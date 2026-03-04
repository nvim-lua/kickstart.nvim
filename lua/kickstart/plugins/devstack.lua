-- lua/kickstart/plugins/devstack.lua
return {
  -- Mason core + LSP glue
  { 'mason-org/mason.nvim', build = ':MasonUpdate', config = true },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        -- LSP servers
        'basedpyright', -- Python
        'ruff', -- Python linter LSP
        'vtsls', -- TypeScript/JavaScript
        'rust_analyzer', -- Rust
      },
      automatic_installation = true,
    },
  },
  {
    -- Auto-install external tools on first start
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        -- Python
        'basedpyright',
        'ruff',
        'black',
        -- TypeScript/JS
        'vtsls',
        'prettierd',
        -- Rust
        'rust-analyzer',
        'codelldb',
        -- git
        'lazygit',
        --markdown
        'markdownlint',
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 6,
    },
  },

  -- Rust UX (recommended)
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ['rust-analyzer'] = {
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = { command = 'clippy' },
            },
          },
        },
      }
    end,
  },

  -- Treesitter parsers preinstalled
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'python',
        'typescript',
        'tsx',
        'javascript',
        'rust',
        'json',
        'toml',
        'yaml',
        'bash',
        'markdown',
        'markdown_inline',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- NeoGit
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim', -- optional but great for diffs
      'nvim-telescope/telescope.nvim', -- optional pickers
    },
    cmd = { 'Neogit' },
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open()
        end,
        desc = 'Neogit',
      },
      {
        '<leader>gc',
        function()
          require('neogit').open { 'commit' }
        end,
        desc = 'Neogit Commit',
      },
      {
        '<leader>gpr',
        function()
          require('neogit').open { 'pull' }
        end,
        desc = 'Neogit Pull',
      },
      {
        '<leader>gp',
        function()
          require('neogit').open { 'push' }
        end,
        desc = 'Neogit Push',
      },
    },
    opts = {
      disable_signs = false,
      disable_commit_confirmation = true,
      integrations = {
        diffview = true, -- use Diffview for diffs/log
        telescope = true, -- Telescope pickers
      },
      kind = 'tab', -- "tab" | "replace" | "floating"
      commit_editor = {
        kind = 'auto', -- smartly choose where to open commit buffer
      },
      mappings = {
        commit_editor = { ['q'] = 'Close' },
        rebase_editor = { ['q'] = 'Close' },
      },
    },
  },
}
