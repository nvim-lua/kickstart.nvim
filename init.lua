-- [[ Neovim Configuration ]]
-- Modular configuration structure for better organization and maintainability

-- Core configuration modules
require 'user.core.globals'  -- Global settings and variables
require 'user.core.options'  -- Vim options and settings
require 'user.core.keymaps'  -- Key mappings and shortcuts
require 'user.core.autocmds' -- Auto commands and events

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- To check the current status of your plugins, run :Lazy
-- To update plugins you can run :Lazy update
require('lazy').setup({
  -- Essential plugins
  'mbbill/undotree',

  -- Comment plugin with custom keybinds
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<leader>/',
      },
      opleader = {
        line = '<leader>/',
      },
    },
  },

  -- Which-key for keybind discovery
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      spec = {
        { '<leader>a', group = 'ai' },
        { '<leader>b', group = 'buffer' },
        { '<leader>d', group = 'debug' },
        { '<leader>f', group = 'find' },
        { '<leader>fn', group = 'neovim config' },
        { '<leader>g', group = 'git' },
        { '<leader>gd', group = 'diff' },
        { '<leader>l', group = 'language' },
        { '<leader>p', group = 'plugins' },
        { '<leader>t', group = 'toggle' },
        { '<leader>u', group = 'ux' },
        { '<leader>w', group = 'workspace' },
        { '<leader>x', group = 'quicklist' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- Telescope fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Telescope keymaps
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
      vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Telescope' })
      vim.keymap.set('n', '<leader>f.', builtin.grep_string, { desc = 'word under cursor' })
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Word' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>f<cr>', builtin.resume, { desc = 'Resume' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>uc', builtin.colorscheme, { desc = 'Find Colorscheme' })

      -- Advanced telescope usage
      vim.keymap.set('n', '<leader>b/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '/ Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Find / in Open Files' })

      -- Neovim config shortcuts
      vim.keymap.set('n', '<leader>fnf', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Find Neovim Files' })
      vim.keymap.set('n', '<leader>fnw', function()
        builtin.live_grep { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Find Neovim Words' })
    end,
  },

  -- Oil file manager
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },

  -- Alignment plugin
  {
    'RRethy/nvim-align',
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LSP keymaps
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Symbols')
          map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>lr', vim.lsp.buf.rename, 'LSP Rename under cursor')
          map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'clangd' then
            map('gs', '<cmd>LspClangdSwitchSourceHeader<cr>', 'Switch between source/header')
          end

          -- Document highlighting
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Language servers configuration
      local servers = {
        clangd = {
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Setup Mason and language servers
      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }

      -- Native LSP config (Neovim 0.11+); nvim-lspconfig supplies the base configs
      vim.lsp.config('*', { capabilities = capabilities })
      for server_name, server in pairs(servers) do
        vim.lsp.config(server_name, server)
      end

      -- Installs servers and auto-enables everything installed through Mason
      require('mason-lspconfig').setup { automatic_enable = true }
    end,
  },

  -- Session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      { "<leader>wr", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>wl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>wd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- Buffer tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = 'v4.*',
    opts = {
      options = {
        separator_style = 'slant',
      },
    },
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
      local neoscroll = require 'neoscroll'
      local keymap = {
        ['[['] = function()
          neoscroll.ctrl_u { duration = 250 }
        end,
        [']]'] = function()
          neoscroll.ctrl_d { duration = 250 }
        end,
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  -- Window maximizer
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>wm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split' },
    },
  },

  -- Flash navigation
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          enabled = false, -- disable ftFT motions enhancement
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      {"S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Colorschemes
  { 'projekt0n/github-nvim-theme', name = 'github', priority = 1000 },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = '#ff0000' },
        }
      end,
    },
  },
  { 'cocopon/iceberg.vim', name = 'iceberg', priority = 1000 },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment guifg=#a883a5 gui=italic'
      vim.cmd.hi 'WinSeparator guifg=#ff0000'
      vim.cmd.set 'laststatus=3'
    end,
  },

  -- Todo comments highlighting
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Scrollbar
  { 'dstein64/nvim-scrollview' },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { {
          'mode',
          fmt = function(res)
            return res:sub(1, 1)
          end,
        } },
        lualine_b = { 'filename' },
        lualine_c = { 'branch' },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'diff' },
        lualine_z = {
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },
    },
  },

  -- Treesitter (main branch, Neovim 0.12+)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- main branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

      local no_indent = { ruby = true }
      local regex_highlight = { ruby = true }

      local function attach(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if regex_highlight[lang] then
          vim.bo[buf].syntax = 'on'
        end
        if not no_indent[lang] then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          -- auto-install missing parsers that nvim-treesitter knows about
          if
            vim.tbl_contains(ts.get_available(), lang)
            and not vim.tbl_contains(ts.get_installed 'parsers', lang)
          then
            ts.install(lang):await(function()
              vim.schedule(function()
                attach(buf, lang)
              end)
            end)
          else
            attach(buf, lang)
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@comment.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },
        move = { set_jumps = true },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      for key, obj in pairs {
        ['aa'] = { '@parameter.outer', 'Select around parameter' },
        ['ia'] = { '@parameter.inner', 'Select inside parameter' },
        ['af'] = { '@function.outer', 'Select around function' },
        ['if'] = { '@function.inner', 'Select inside function' },
        ['ac'] = { '@class.outer', 'Select around class/struct' },
        ['ic'] = { '@class.inner', 'Select inside class/struct' },
        ['ii'] = { '@conditional.inner', 'Select inside if' },
        ['ai'] = { '@conditional.outer', 'Select around if' },
        ['il'] = { '@loop.inner', 'Select inside loop' },
        ['al'] = { '@loop.outer', 'Select around loop' },
        ['a/'] = { '@comment.outer', 'Select around comment' },
      } do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(obj[1], 'textobjects')
        end, { desc = obj[2] })
      end

      local move = require 'nvim-treesitter-textobjects.move'
      for _, m in ipairs {
        { ']f', 'goto_next_start', '@function.outer', 'Next function start' },
        { ']C', 'goto_next_start', '@class.outer', 'Next class start' },
        { ']i', 'goto_next_start', '@conditional.outer', 'Next if' },
        { ']l', 'goto_next_start', '@loop.outer', 'Next loop' },
        { ']/', 'goto_next_start', '@comment.outer', 'Next comment' },
        { ']F', 'goto_next_end', '@function.outer', 'Next function end' },
        { '[f', 'goto_previous_start', '@function.outer', 'Previous function start' },
        { '[C', 'goto_previous_start', '@class.outer', 'Previous class start' },
        { '[i', 'goto_previous_start', '@conditional.outer', 'Previous if' },
        { '[l', 'goto_previous_start', '@loop.outer', 'Previous loop' },
        { '[/', 'goto_previous_start', '@comment.outer', 'Previous comment' },
        { '[F', 'goto_previous_end', '@function.outer', 'Previous function end' },
      } do
        vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
          move[m[2]](m[3], 'textobjects')
        end, { desc = m[4] })
      end
    end,
  },

  -- Development tools
  'dstein64/vim-startuptime',

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.cmd [[
           let g:mkdp_echo_preview_url = 1
           let g:mkdp_open_to_the_world = 0
           let g:mkdp_open_ip = '127.0.0.1'
           let g:mkdp_port = '8080'
        ]]
    end,
  },

  -- Import modular plugin configurations
  { import = 'user/plugins' },
}, {
  rocks = { enabled = false }, -- no plugin needs luarocks; avoids hererocks health errors
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et