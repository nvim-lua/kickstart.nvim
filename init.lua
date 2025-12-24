--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
  ros2-with-neovim is heavily inspired from Kickstart.nvim.

  I have basically taken the same approach of having a single file where all the
  main configurations are done commenting clearly what all of them do.

  You should consider this as a starting point into your Neovim journey. Then, you can
  start to add as many plugins and configurations as you see fit :).
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
-- INFO: There are different plugins manager for neovim. I prefer Lazy
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

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- INFO: Git related plugins
  'voldikss/vim-floaterm',
  'tpope/vim-fugitive', -- Git wrapper for vim
  'rhysd/conflict-marker.vim', -- weapon to fight against merge conflicts
  { 'kylechui/nvim-surround', config = true },
  { 'numToStr/Comment.nvim', opts = {} },
  'rhysd/git-messenger.vim', -- Shows commit message under cursor
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'echo $OPENAI_API_KEY',
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim', -- Similar to fugitive, but adds additiona functionality
    event = 'VeryLazy',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
      }
    end,
  },
  {
    'sindrets/diffview.nvim', -- Single tabpage interface for easily cycling through diffs
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  { -- Quick selection of co-authors
    'ErickKramer/git-coauthors.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  -- INFO: Enhance Editor Experience
  {
    'iamcco/markdown-preview.nvim', -- Markdown previewer
    -- event = "VeryLazy",
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      -- Refresh markdown when saving the buffer or leaving insert mode
      vim.g.mkdp_refresh_slow = 1

      -- Fancy title
      vim.g.mkdp_page_title = '「${name}」'

      -- Dark mode (of course)
      vim.g.mkdp_theme = 'dark'

      -- Avoid auto close
      vim.g.mkdp_auto_close = 0

      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'gruvbox-material'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'f4z3r/gruvbox-material.nvim',
    name = 'gruvbox-material',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  'mg979/vim-visual-multi', -- Enable multicursor
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = false, -- fully hide
          hide_dotfiles = true,
          hide_gitignored = true,

          hide_by_name = {
            '.git',
            '.elc',
          },

          hide_by_pattern = {
            '*.uid', -- ✅ correct
            'node_modules',
          },
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  'nvim-tree/nvim-web-devicons', -- Add fancy icons
  -- {
  --   'nvim-tree/nvim-tree.lua', -- File tree
  --   config = function()
  --     -- Config needed for nvim-tree
  --     vim.g.loaded_netrw = 1
  --     vim.g.loaded_netrwPlugin = 1
  --     require('nvim-tree').setup {
  --       sort_by = 'case_sensitive',
  --       view = {
  --         adaptive_size = false,
  --         relativenumber = true,
  --         width = 40,
  --       },
  --       renderer = {
  --         group_empty = true,
  --       },
  --       filters = {
  --         dotfiles = true,
  --       },
  --     }
  --   end,
  -- },
  {
    'folke/todo-comments.nvim', -- Fancy TODOs/FIXMEs
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },
  { -- Improve file navigation with search labels
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      -- {
      --   's',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').jump()
      --   end,
      --   desc = 'Flash',
      -- },
      -- {
      --   'S',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').treesitter()
      --   end,
      --   desc = 'Flash Treesitter',
      -- },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'folke/trouble.nvim', -- Quickfix list for LSP errors
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        signs = {
          -- icons / text used for a diagnostic
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '﫠',
        },
      }
    end,
  },
  {
    'folke/which-key.nvim', -- Popup with possible keybindings of the command you started to type
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    config = function()
      local function get_venv()
        local venv = vim.env.VIRTUAL_ENV
        if venv then
          local env = string.match(venv, '[^/]+$')
          return ' ' .. env
        else
          return ''
        end
      end

      local ros_distro = vim.fn.expand '$ROS_DISTRO'

      local function get_ros_distro()
        if ros_distro and ros_distro ~= '$ROS_DISTRO' then
          return '󰭆 ' .. ros_distro
        else
          return ''
        end
      end
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox-material',
          component_separators = '|',
          section_separators = '',
          ignore_focus = {
            'dapui_watches',
            'dapui_breakpoints',
            'dapui_scopes',
            'dapui_console',
            'dapui_stacks',
            'dap-repl',
          },
          disabled_filetypes = { 'NvimTree' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { { get_venv }, { get_ros_distro }, 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },
  {
    'nvim-pack/nvim-spectre', -- Advance Search and Replace
    opts = {},
  },
  {
    'goolord/alpha-nvim', -- Greeter dashboard
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[██████╗  ██████╗ ███████╗]],
        [[██╔══██╗██╔═══██╗██╔════╝]],
        [[██████╔╝██║   ██║███████╗]],
        [[██╔══██╗██║   ██║╚════██║]],
        [[██║  ██║╚██████╔╝███████║]],
        [[╚═╝  ╚═╝ ╚═════╝ ╚══════╝]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
        dashboard.button('u', '  Update plugins', ':Lazy sync<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }
      local handle = io.popen 'fortune'
      local fortune = handle:read '*a'
      handle:close()
      dashboard.section.footer.val = fortune

      dashboard.config.opts.noautocmd = true

      vim.cmd [[autocmd User AlphaReady echo 'ready']]

      alpha.setup(dashboard.config)
    end,
  },
  {
    'romgrk/barbar.nvim', -- Tabline plugin that improves buffers and tabs
    event = 'BufEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    lazy = true,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)
      require('ibl').setup {
        indent = { highlight = highlight, char = '┊' },
        scope = { enabled = false },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim', -- Improve handling neovim terminals
    opts = {},
    config = function()
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.diagnostic.disable(0)
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      end

      -- ====================================================
      -- Custom terminals
      -- ====================================================
      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new {
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        float_opts = { -- Get floating window in full screen
          width = vim.o.columns,
          height = vim.o.lines,
        },
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.diagnostic.disable(0)
          vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
          if vim.fn.mapcheck('<esc>', 't') ~= '' then
            vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
          end
        end,
      }

      function _lazygit_toggle()
        -- lazygit.dir = vim.fn.getcwd() -- Open lazygit in the current working directory
        lazygit.dir = vim.fn.expand '%:p:h' -- Open lazygit in the repository from the file
        lazygit:toggle()
      end

      local python = Terminal:new {
        cmd = 'ipython3',
        direction = 'horizontal',
        hidden = true,
        hidden_numbers = true,
      }

      function _python_toggle()
        python:toggle()
      end

      -- Fancy terminals
      vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ip', '<cmd>lua _python_toggle()<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
    config = function()
      require('dressing').setup {
        input = {
          get_config = function()
            return {
              title_pos = 'center',
              win_options = {
                sidescrolloff = 10,
              },
              insert_only = false,
            }
          end,
        },
      }
    end,
  },
  { -- Color theme
    'navarasu/onedark.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'benfowler/telescope-luasnip.nvim', -- Allows to search the available snippet
      'nvim-telescope/telescope-live-grep-args.nvim', -- Enable passing arguments to ripgrep
    },
    config = function()
      local actions = require 'telescope.actions'
      require('telescope').setup {
        defaults = {
          prompt_prefix = '🔍 ',
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--follow',
          },
          path_display = {
            truncate = 3,
          },
          mappings = {
            i = {
              ['<C-t>'] = actions.select_tab, -- open in new tab
              ['<C-v>'] = actions.select_vertical, -- open in vsplit
              ['<C-x>'] = actions.select_horizontal, -- open in split
            },
            n = {
              ['<C-t>'] = actions.select_tab,
              ['<C-v>'] = actions.select_vertical,
              ['<C-x>'] = actions.select_horizontal,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '-g',
              '!.git',
            },
            follow = true,
          },
          lsp_document_symbols = {
            show_line = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
        },
      }
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'luasnip'
      require('telescope').load_extension 'live_grep_args'
      -- require('telescope').load_extension 'coauthors'
    end,
  },

  --
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {
            -- Options related to notification subsystem
            notification = {
              -- Options related to the notification window and buffer
              window = {
                normal_hl = 'Comment', -- Base highlight group in the notification window
                border = 'rounded', -- Border around the notification window
                zindex = 45, -- Stacking priority of the notification window
                max_width = 0, -- Maximum width of the notification window
                max_height = 0, -- Maximum height of the notification window
                x_padding = 1, -- Padding from right edge of window boundary
                y_padding = 0, -- Padding from bottom edge of window boundary
                align = 'bottom', -- How to align the notification window
                relative = 'editor', -- What the notification window position is relative to
              },
            },
          }
        end,
      },
    },
    config = function()
      -- INFO: LSP Settings
      -- This contains the configuration of several components related to LSPs
      -- - luasnip
      -- - mason
      -- - mason-lspconfig
      -- - nvim-cmp
      -- - nvim-lspconfig

      -- PERF:
      -- ====================================================
      -- LSP Keymaps
      -- ====================================================

      --  This function gets run when an LSP connects to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('personal-lsp-attach', { clear = true }),
        callback = function(event)
          -- Create a wrapper function to simplify keymaps creation
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          --  Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
          -- NOTE: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header

          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- PERF:
      -- ====================================================
      -- LSP Servers
      -- ====================================================
      local servers = {
        clangd = {
          cmd = {
            -- see clangd --help-hidden
            'clangd',
            '--background-index',
            -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
            -- to add more checks, create .clang-tidy file in the root directory
            -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
            '--clang-tidy',
            '--completion-style=bundled',
            '--cross-file-rename',
            '--header-insertion=iwyu',
          },
        },
        pyright = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
              useLibraryCodeForTypes = true,
              reportDuplicateImport = true,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  'vim',
                  'require',
                },
              },
            },
          },
        },
        rust_analyzer = {},
      }

      -- PERF:
      -- ====================================================
      -- capabilities Configuratioon
      -- ====================================================

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.offsetEncoding = { 'utf-16' }
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Enable folding (for nvim-ufo)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- PERF:
      -- ====================================================
      -- Mason Configuratioon
      -- ====================================================

      -- Setup mason so it can manage external tooling
      require('mason').setup {
        ui = {
          border = 'rounded',
        },
      }

      -- mason-lspconfig configurations
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      require('mason-tool-installer').setup {

        -- List of all DAP, Linter and Formatters to install
        ensure_installed = {
          -- LSPs
          'clangd',
          'lua_ls',
          'pyright',
          'ruff',

          -- DAP
          'codelldb',
          'cpptools',

          -- Linter
          'cpplint',

          -- Formatters
          'stylua',
          'prettier',
        },

        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 3000, -- 3 second delay

        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      }

      -- PERF:
      -- ====================================================
      -- nvim-cmp configuration
      -- ====================================================

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- performance = {
        --   max_view_entries = 20,
        -- },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp', max_item_count = 10 },
          { name = 'luasnip' },
          { name = 'path', max_item_count = 5 },
          { name = 'buffer', max_item_count = 5 },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }

      -- Suggested approach to cancel snippet session after going back to normal mode
      -- Taken from https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
      function leave_snippet()
        if
          ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
        then
          require('luasnip').unlink_current()
        end
      end

      -- stop snippets when you leave to normal mode
      vim.api.nvim_command [[ autocmd ModeChanged * lua leave_snippet() ]]

      -- Custom command to disable completion
      local cmp_enabled = true
      vim.api.nvim_create_user_command('ToggleAutoComplete', function()
        if cmp_enabled then
          require('cmp').setup.buffer { enabled = false }
          cmp_enabled = false
        else
          require('cmp').setup.buffer { enabled = true }
          cmp_enabled = true
        end
      end, {})

      -- Configure cmp-cmdline
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })

      -- PERF:
      -- ====================================================
      -- LSP related UI Configurations
      -- ====================================================

      -- Add bordered to LSP info
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      -- INFO: Configure LSP textDocuments
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

      -- Diagnostic signs
      local diagnostic_signs = {
        { name = 'DiagnosticSignError', text = ' ' },
        { name = 'DiagnosticSignWarn', text = ' ' },
        { name = 'DiagnosticSignHint', text = ' ' },
        { name = 'DiagnosticSignInfo', text = ' ' },
      }
      for _, sign in ipairs(diagnostic_signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.diagnostic.config {
        virtual_text = {
          prefix = '●', -- Could be '■', '▎', 'x'
        },
        severity_sort = true,
        float = {
          source = 'always', -- Or "if_many"
        },
        signs = true,
      }
    end,
  },
  { -- Formatter
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          json = { { 'prettierd', 'prettier' } },
          lua = { 'stylua' },
          markdown = { 'prettier' },
          -- Conform will run multiple formatters sequentially
          python = function(bufnr)
            if require('conform').get_formatter_info('ruff_format', bufnr).available then
              return { 'ruff_format' }
            else
              return { 'isort', 'black' }
            end
          end,
          yaml = { 'prettier' },
          ['*'] = { 'injected' },
        },
        ignore_errors = true,
        -- Map of treesitter language to file extension
        -- A temporary file name with this extension will be generated during formatting
        -- because some formatters care about the filename.
        lang_to_ext = {
          bash = 'sh',
          latex = 'tex',
          markdown = 'md',
          python = 'py',
        },
      }
      --
      -- set up Format and <leader>f commands which should behave equivalently
      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format { async = true, lsp_fallback = true, range = range }
      end, { range = true })
      vim.keymap.set('', '<leader>fa', function()
        require('conform').format { async = true, lsp_fallback = true }
      end, { desc = '[F]ormat [a]ll' })
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
      'hrsh7th/cmp-buffer', -- Source for buffer words
      'hrsh7th/cmp-path', -- Add source filesystem path
      'hrsh7th/cmp-cmdline', -- Source for vim's cmdline
    },
  },
  {
    'rafamadriz/friendly-snippets', -- Snippets collection
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      require('luasnip/loaders/from_vscode').lazy_load {
        paths = {
          vim.fn.stdpath 'config' .. '/snippets',
        },
      }
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = {
            'bash',
            'c',
            'cpp',
            'csv',
            'dockerfile',
            'gitcommit',
            'gitignore',
            'go',
            'html',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
            'rust', -- add this if you want it for Rust
            -- add any others: 'javascript', 'typescript', etc
          },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,
          highlight = {
            enable = true,
            disable = function(lang, bufnr) -- Disable in large files
              return vim.api.nvim_buf_line_count(bufnr) > 50000
            end,
            additional_vim_regex_highlighting = false,
          },
          indent = { enable = true, disable = { 'python', 'cpp' } },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<M-space>',
              node_incremental = '<M-space>',
              -- scope_incremental = '<C-s>',
              node_decremental = '<M-backspace>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end, 0)

      -- Configure highlight group for treesittercontext
      vim.cmd [[ hi TreesitterContextBottom gui=underline guisp=#a6e3a1 ]]
    end,
  },
  -- INFO: Debug adapters
  {
    'mfussenegger/nvim-dap', -- Enable debug adapters
    dependencies = {
      'mfussenegger/nvim-dap-python', -- Python debug adapter
      'rcarriga/nvim-dap-ui', -- UI-like for debugging
      'theHamsta/nvim-dap-virtual-text', -- Inline text during debugging
      'nvim-neotest/nvim-nio', -- Needed by nvim-dap-ui
      'folke/neodev.nvim', -- Recommended by nvim-dap-ui
    },
    config = function()
      require('neodev').setup {
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      }
      -- PERF:
      -- ===================================================
      -- UI related configurations
      -- ====================================================
      local dap = require 'dap'
      local sign = vim.fn.sign_define

      sign('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      sign('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      sign('DapLogPoint', { text = '◆ ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      sign('DapStoppedLine', { text = '󰁕 ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      sign('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

      -- PERF:
      -- ===================================================
      -- Adapters
      -- ====================================================
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.expand '$HOME/.local/share/nvim/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }
      -- PERF:
      -- ===================================================
      -- Configurations
      -- ====================================================
      dap.configurations.cpp = {
        {
          name = 'C++: Run file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          -- If you get an "Operation not permitted" error using this, try disabling YAMA:
          --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          name = 'C++: Attach to process',
          type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
        },
        {
          name = 'C++: ROS Node',
          type = 'codelldb',
          request = 'launch',
          -- Might need to consider using vim.ui.input
          program = function()
            local pkgName = vim.fn.input('ROS Package: ', '')
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/install/' .. pkgName .. '/lib/' .. pkgName .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      -- PERF:
      -- ====================================================
      -- Extensions configurations
      -- ====================================================
      require('dapui').setup {
        controls = {
          icons = {
            pause = '⏸ ',
            play = '▶ ',
            terminate = '⏹ ',
          },
        },
        floating = {
          border = 'rounded',
        },
        layouts = {
          {
            elements = {
              { id = 'stacks', size = 0.30 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'scopes', size = 0.50 },
            },
            position = 'left',
            size = 40,
          },
          {
            elements = {
              { id = 'console', size = 0.50 },
              { id = 'repl', size = 0.50 },
            },
            position = 'bottom',
            size = 10,
          },
        },
      }
      require('nvim-dap-virtual-text').setup()
      require('dap-python').setup()
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Python: ROS2 lauch test',
        program = '/opt/ros/humble/bin/launch_test',
        args = { '${file}' },
      })

      require('dap-python').test_runner = 'pytest'

      -- PERF:
      -- ====================================================
      -- Custom User Commands for Dap
      -- ====================================================
      vim.api.nvim_create_user_command('DapUIToggle', ":lua require('dapui').toggle()", {})
      vim.api.nvim_create_user_command('DapPytestMethod', ":lua require('dap-python').test_method()", {})

      vim.api.nvim_create_user_command('DapResetUI', ":lua require('dapui').open({reset = true})", { desc = 'Reset DAP UI Layout' })

      vim.api.nvim_create_user_command(
        'DapLogBreakpoint',
        ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log Message: '))",
        { desc = 'Set log message breakpoint' }
      )
      vim.api.nvim_create_user_command(
        'DapConditionBreakpoint',
        ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: '))",
        { desc = 'Set conditional breakpoint' }
      )
      vim.api.nvim_create_user_command(
        'DapConditionHitBreakpoint',
        ":lua require('dap').set_breakpoint(vim.fn.input('Breapoint Condition: '), vim.fn.input('Hit Condition: '))",
        { desc = 'Set condition and hit breakpoint' }
      )
      vim.api.nvim_create_user_command(
        'DapHitBreakpoint',
        ":lua require('dap').set_breakpoint(nil, vim.fn.input('Hit Condition: '))",
        { desc = 'Set hit breakpoint' }
      )

      -- PERF:
      -- ====================================================
      -- Configure DAP UI Listeners
      -- ====================================================
      local dapui = require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  -- NOTE: Here you can add additional plugins that can enhance your Neovim Journey
  { -- ROS2 related plugin
    'ErickKramer/nvim-ros2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      autocmds = true,
      telescope = true,
      treesitter = true,
    },
  },
}, {})

--[[INFO: Editor Settingss
 --   Take the time to check the settings underneath and configure them base on your needs and preferences
 --]]
-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Keep signcolumn on
vim.wo.signcolumn = 'yes'
vim.opt.signcolumn = 'yes:1' -- Enable expanding signcolumn

-- Highlight current line
vim.opt.cursorline = true

-- Render the column delimiter
vim.opt.colorcolumn = '100'

-- Prefer spaces of 2 over tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Render trailing spaces
vim.opt.listchars = { trail = '⇲', tab = '◦ ' }
vim.opt.list = true

-- Share system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Relative line numbers
local numtogGrp = vim.api.nvim_create_augroup('NumberToggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'FocusGained' }, {
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = true
  end,
  group = numtogGrp,
  desc = 'Turn on relative line numbering when the buffer is entered.',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter', 'FocusLost' }, {
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = false
  end,
  group = numtogGrp,
  desc = 'Turn off relative line numbering when the buffer is exited.',
})

--[[ INFO: Keymaps configurations
--    Make sure to change these keymaps so that they make the most sense to you
--]]

-- Improve motions
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines down' })

-- Improve splits navigation
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Improve pasting
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Preserve previous word when pasting' })

vim.keymap.set('n', '<leader>ya', ':%y+<CR>', { desc = 'Yank all content in file' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic in floating window' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Send diagnostic to loclist' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable, { desc = '[D]iagnostics [D]disable' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.enable, { desc = '[D]iagnostics [E]nable' })

-- Change workingdir
vim.keymap.set('n', '<leader>cw', ':cd %:p:h<CR>:pwd<CR>', { desc = 'Change current workding dir' })
-- Fix forward jump after setting <TAB>
-- https://github.com/neovim/neovim/issues/20126
vim.keymap.set('n', '<C-I>', '<C-I>', { noremap = true })

-- Editor experience
vim.keymap.set('n', '<C-s>', ':write<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>cd', ':ToggleAutoComplete<CR>', { desc = '[C]ompletion [D]isable' })
vim.keymap.set('n', '<leader>ce', ':ToggleAutoComplete<CR>', { desc = '[C]ompletion [E]nable' })

-- ====================================================
-- Telescope
-- ====================================================
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
    sorting_strategy = 'ascending',
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').spell_suggest, { desc = '[S][P]ell suggestion' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').git_commits, { desc = '[S]earch git [C]ommits' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Telescope [S]earch [R]esume' })
-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })
-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- ====================================================
-- Nvim Tree
-- ====================================================
vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', { desc = 'NvimTree [F]ind [F]ile' })
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { desc = 'NvimTree [T]ree [T]oggle' })

-- ====================================================
-- Execute over files
-- ====================================================
vim.keymap.set('n', '<leader>ru', ':w<CR>:!%:p', { desc = '[R][U]n current file' })
vim.keymap.set('n', '<leader>me', ':!chmod +x %:p<CR>', { desc = '[M]ake current file [E]xecutable' })

-- ====================================================
-- Spectre
-- ====================================================
vim.keymap.set('n', '<leader>P', require('spectre').open, { desc = 'Open Search and Replace' })

-- ====================================================
-- Trouble
-- ====================================================
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true, desc = 'Toggle trouble window' })
vim.keymap.set(
  'n',
  '<leader>xw',
  '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Trouble diagnostics for the whole workspace' }
)
vim.keymap.set(
  'n',
  '<leader>xd',
  '<cmd>TroubleToggle document_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Trouble diagnostics for current document' }
)

-- ====================================================
-- Uncrustify
-- ====================================================
vim.api.nvim_create_user_command(
  'Uncrustify',
  -- ":!uncrustify -c /home/ekramer/evobot_ecosystem/humble_ws/ament_code_style.cfg --replace %:p -q --no-backup", {}
  ':!ament_uncrustify --reformat %:p',
  {}
)

-- ====================================================
-- Debugging -> dap
-- ====================================================
vim.keymap.set('n', '<F2>', ":lua require('dapui').toggle()<CR>")
vim.keymap.set('n', '<leader>dc', ":lua require('dap').continue()<CR>")
vim.keymap.set('n', '<leader>do', ":lua require('dap').step_over()<CR>")
vim.keymap.set('n', '<leader>di', ":lua require('dap').step_into()<CR>")
vim.keymap.set('n', '<leader>dk', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>du', ":lua require('dap').step_out()<CR>")
vim.keymap.set('n', '<leader>dl', ":lua require('dapui').float_element()<CR>", { silent = true, noremap = true, desc = 'Open floating window in Dap UI' })
vim.keymap.set('n', '<leader>dt', ":lua require('dap').toggle_breakpoint()<CR>", { silent = true, noremap = true, desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dm', ":lua require('dap-python').test_method()<CR>", { silent = true, noremap = true, desc = 'DapPytest : Debug method' })
vim.keymap.set('n', '<leader>df', ":lua require('dap-python').test_class()<CR>", { silent = true, noremap = true, desc = 'DapPytest : Debug class' })

-- ====================================================
-- barbar --> Tabs management
-- ====================================================
vim.keymap.set('n', '<A-,>', '<cmd>BufferPrevious<cr>', { silent = true, noremap = true, desc = 'Go to previous tab' })
vim.keymap.set('n', '<A-.>', '<cmd>BufferNext<cr>', { silent = true, noremap = true, desc = 'Go to next tab' })
vim.keymap.set('n', '<A-c>', '<cmd>BufferClose<cr>', { silent = true, noremap = true, desc = 'Close current buffer' })
local opts = { noremap = true, silent = true }
-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- ====================================================
-- Quickfix
-- ====================================================
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Next quickfix list' })
vim.keymap.set('n', '<leader>cp', ':cprevious<CR>', { desc = 'Previous quickfix list' })

-- ====================================================
-- Markdown
-- ====================================================
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = '[M]arkdown [P]review' })

-- ====================================================
-- nvim-ros2
-- ====================================================
vim.keymap.set('n', '<leader>li', ':Telescope ros2 interfaces<CR>', { desc = '[ROS 2]: List interfaces' })
vim.keymap.set('n', '<leader>ln', ':Telescope ros2 nodes<CR>', { desc = '[ROS 2]: List nodes' })
vim.keymap.set('n', '<leader>la', ':Telescope ros2 actions<CR>', { desc = '[ROS 2]: List actions' })
vim.keymap.set('n', '<leader>lt', ':Telescope ros2 topics<CR>', { desc = '[ROS 2]: List topics' })
vim.keymap.set('n', '<leader>ls', ':Telescope ros2 services<CR>', { desc = '[ROS 2]: List services' })

-- ====================================================
-- git_coauthors
-- ====================================================
vim.keymap.set('n', '<leader>ga', ':Telescope coauthors<CR>', { desc = '[G]it co-[A]uthors' })

-- NOTE: Custon User Commads

-- ====================================================
-- ROS 2 related commands
-- ====================================================
vim.api.nvim_command [[
  command! ColconBuild :! CC=clang CXX=clang++ colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
]]
vim.api.nvim_command [[
  command! -nargs=1 ColconBuildSingle :! CC=clang CXX=clang++ colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON --packages-up-to <args>
]]
vim.api.nvim_command [[
  command! ColconBuildDebug :! CC=clang CXX=clang++ colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug
]]
vim.api.nvim_command [[
  command! -nargs=1 ColconBuildDebugSingle :! CC=clang CXX=clang++ colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug --packages-up-to <args>
]]

-- Test
vim.api.nvim_command [[
  command! ColconTest :! colcon test
]]
vim.api.nvim_command [[
  command! -nargs=1 ColconTestSingle :! colcon test --packages-select <args>
]]
vim.api.nvim_command [[
  command! ColconTestResult :! colcon test-result --all
]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.api.nvim_set_keymap('n', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true })

-- map floaterm
vim.api.nvim_set_keymap('n', '<C-t>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-t>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })
--
-- Define the toggle function
local function toggle_neotree()
  local manager = require 'neo-tree.sources.manager'
  local renderer = require 'neo-tree.ui.renderer'

  local state = manager.get_state 'filesystem'
  local window_exists = renderer.window_exists(state)
  if window_exists then
    vim.cmd 'Neotree close'
  else
    vim.cmd 'Neotree show'
  end
end

-- Ensure the function is accessible
_G.toggle_neotree = toggle_neotree

-- Map the toggle function to a key command
vim.api.nvim_set_keymap('n', '<C-n>', ':lua toggle_neotree()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<C-f>', ':lua toggle_neotree()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-f>', ':lua toggle_neotree()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_augroup('EnsureTextWindowFocus', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = 'EnsureTextWindowFocus',
  callback = function()
    vim.defer_fn(function()
      vim.cmd 'wincmd p'
    end, 100) -- Adjust the delay if necessary
  end,
})

-- tabstop 2
vim.api.nvim_create_augroup('CppIndent', { clear = true })

-- Set tab width to 2 spaces for C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'c', 'cc', 'h', 'hpp' },
  group = 'CppIndent',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Remap copy line
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true })
-- Open Neo-tree automatically on startup
-- vim.cmd 'Neotree show'
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-w>', '<cmd>wqa<cr>')

-- Quick splits
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Horizontal split' })

local ai_enabled = true

-- AI toggle
local ai_enabled = true
vim.keymap.set('n', '<leader>at', function()
  ai_enabled = not ai_enabled
  print(ai_enabled and 'AI enabled' or 'AI disabled')
end, { desc = 'Toggle AI' })

-- Safe wrapper
local function ai_safe(cmd)
  return function()
    if not ai_enabled then
      print 'AI is disabled'
      return
    end
    vim.cmd(cmd)
  end
end

-- Keymaps using safe wrapper
vim.keymap.set('n', '<leader>ai', ai_safe 'ChatGPT', { desc = 'Open ChatGPT UI' })
vim.keymap.set('v', '<leader>ac', ai_safe 'ChatGPTEditWithInstruction', { desc = 'AI edit code' })
vim.keymap.set('v', '<leader>ae', ai_safe 'ChatGPTExplain', { desc = 'Explain code' })

-- creates a new tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
-- closes a tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })

-- kills floaterms
vim.keymap.set('n', '<leader>fk', ':FloatermKill!<CR>', { desc = 'Kill all floaterms' })

vim.keymap.set('x', 'S', '<Plug>(nvim-surround-visual)', { remap = true })

-- delete by word with ctrl backspace
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true })
vim.keymap.set('c', '<C-BS>', '<C-w>', { noremap = true })

-- switch buffers quicker with shift+tab
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>')
