-- [[ Setting options ]]
vim.g.mapleader = ' ' -- bindings for global
vim.g.maplocalleader = ',' -- bindings for local
vim.o.hlsearch = true
vim.o.colorcolumn = '80,120' -- column width
vim.o.number = true
vim.o.relativenumber = true -- relative numbers
vim.o.mouse = 'a' -- enable mouse
vim.o.clipboard = 'unnamedplus' -- see :h clipboard
vim.o.breakindent = true
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching
vim.o.smartcase = true
vim.wo.signcolumn = 'yes' -- signcolumn to the left of the numbers
vim.o.updatetime = 250 -- Decrease update time
vim.o.completeopt = 'menuone,noselect' -- a better completion experience
vim.o.termguicolors = true -- all the colors
vim.o.tabstop = 2 -- Set whitespace to be 2 always
vim.o.shiftwidth = 2 -- Set whitespace to be 2 always
vim.o.softtabstop = 2 -- Set whitespace to be 2 always
vim.o.expandtab = true -- spaces are better than tabs

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- silence the normal <Space>
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up half page' }) -- center while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down half page' }) -- center while scrolling
vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = 'Next Buffer', silent = true }) -- easily change buffers
vim.keymap.set('n', '<C-k>', ':bprev<CR>', { desc = 'Previous Buffer', silent = true }) -- easily change buffers
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = 'Delete Buffer', silent = true }) -- close buffer
vim.cmd [[ nnoremap <silent> <expr> <CR> {-> v:hlsearch ? "<cmd>nohl\<CR>" : "\<CR>"}() ]] -- clear the highlighted search with <CR>
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- Remap for dealing with word wrap

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- configure plugins in the following
require('lazy').setup({
  'tpope/vim-sleuth',
  'numToStr/Comment.nvim',

  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        clojure = { 'cljfmt' },
        go = { 'gofmt', 'goimports' },
        c = { 'clang_format' },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 350
    end,
    config = function()
      require('which-key').setup()

      -- document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: `build` is used to run some command when the plugin is installed/updated.
        --  This is only run then, not every time Neovim starts up.
        build = 'make',

        -- NOTE: `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            '%.git',
            'node_modules',
            '%.idea',
            'project/target', --https://www.lua.org/pil/20.2.html
            'target', --https://www.lua.org/pil/20.2.html
            '%.cache',
            '%.cpcache',
            'cljs%-runtime',
          },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'fzf')

      local builtin = require 'telescope.builtin'
      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function() -- live grep open files
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[/] in Open Files' })

      vim.keymap.set('n', '<leader>sF', function() -- search files but include ignored files
        builtin.find_files {
          no_ignore = true,
        }
      end, { desc = '[S]earch [F]iles (no ignore)' })

      vim.keymap.set('n', '<leader>sn', function() -- Shortcut for searching your neovim configuration files
        builtin.find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymap' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sv', builtin.git_files, { desc = '[S]earch [V]ersion Control (git)' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch [g]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      require('neodev').setup()

      local on_attach = function(_, bufnr) --  This function gets run when an LSP connects to a particular buffer.
        local nmap = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- Important LSP Navigation keybinds
        --  To jump back, press <C-T>.
        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>lt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>lsd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>lsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- NOTE: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        nmap('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename') -- Rename the variable under your cursor
        nmap('<leader>lc', function()
          vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
        end, '[L]SP [C]ode Action')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation') -- See `:help K` for why this keymap
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation') -- Show the signature of the function you're currently completing.
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = {
        clangd = {},
        gopls = {},
        clojure_lsp = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers above are installed
      require('mason').setup()

      local installed = {
        'stylua',
        'clj-kondo',
        'zprint',
        'goimports',
        'golangci-lint',
      }
      vim.list_extend(installed, vim.tbl_keys(servers))
      require('mason-tool-installer').setup { ensure_installed = installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup {
              cmd = server.cmd,
              settings = server.settings,
              filetypes = server.filetypes,
              on_attach = on_attach,
              -- capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities),
              capabilities = server.capabilities or capabilities,
            }
          end,
        },
      }
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- add flair to the cmp suggestions
      'onsails/lspkind.nvim',

      -- other sources
      'hrsh7th/cmp-buffer',
      'PaterJason/cmp-conjure',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Select the [n]ext item
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function() -- <c-l> will move you to the right of each of the expansion locations.
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'conjure' },
          { name = 'path' },
          { name = 'buffer' },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            menu = {
              buffer = '[Buffer]',
              conjure = '[Conjure]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
              luasnip = '[LuaSnip]',
            },
          },
        },
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better Around/Inside textobjects
      require('mini.surround').setup() -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.statusline').setup() -- Simple and easy statusline.
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
      }
    end,
  },

  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  { import = 'custom.plugins' },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
