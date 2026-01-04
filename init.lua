vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

-- install deps if need to
require 'bootstrap.pacman'

-- =========================
-- Lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- PLUGINS
-- =========================
require('lazy').setup({
  'voldikss/vim-floaterm',

  'tpope/vim-fugitive',

  'rhysd/conflict-marker.vim',

  { 'kylechui/nvim-surround', config = true },

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'karb94/neoscroll.nvim',
    opts = {},
    config = function()
      local neoscroll = require 'neoscroll'

      neoscroll.setup {
        -- remove <C-u>/<C-d> from defaults so your custom maps win
        mappings = {
          '<C-b>',
          '<C-f>',
          '<C-y>',
          '<C-e>',
          'zt',
          'zz',
          'zb',
        },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        duration_multiplier = 0.3, -- Global duration multiplier
        easing = 'quadratic', -- Default easing function
        pre_hook = function(info)
          if info == 'center' then
            vim.cmd 'normal! M'
          end
        end,
        post_hook = nil,
      }
      local function near_file_edge()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local last = vim.api.nvim_buf_line_count(0)
        local so = vim.wo.scrolloff
        return line <= so + 1 or line >= last - so
      end

      local modes = { 'n', 'v', 'x' }

      vim.keymap.set(modes, '<C-d>', function()
        neoscroll.ctrl_d { duration = 300 }
        if not near_file_edge() then
          vim.cmd 'normal! M'
        end
      end)

      vim.keymap.set(modes, '<C-u>', function()
        neoscroll.ctrl_u { duration = 300 }
        if not near_file_edge() then
          vim.cmd 'normal! M'
        end
      end)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'rust',
        'python',
        'javascript',
        'typescript',
        'c',
        'c_sharp',
        'cpp',
        'bash',
        'json',
        'yaml',
        'toml',
      },
      highlight = {
        enable = true,
      },
    },
  },

  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<A-Space>', -- Alt+Space
          node_incremental = '<A-Space>', -- Alt+Space (expand)
          node_decremental = '<A-BS>', -- Alt+Backspace (shrink)
          scope_incremental = '<A-S-Space>', -- Alt+Shift+Space (scope expand)
        },
      },
    },
  },

  'rhysd/git-messenger.vim',

  {
    'lewis6991/gitsigns.nvim',
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
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'ErickKramer/git-coauthors.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Editor UX
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
  },

  {
    'sphamba/smear-cursor.nvim',
    opts = {
      time_interval = 3,
      cursor_color = '#ff4000',
      particles_enabled = true,
      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.6,
      gradient_exponent = 0,
      gamma = 1,
      never_draw_over_target = true,
      hide_target_hack = true,
      particle_spread = 1,
      particles_per_second = 500,
      particles_per_length = 50,
      particle_max_lifetime = 800,
      particle_max_initial_velocity = 20,
      particle_velocity_from_cursor = 0.5,
      particle_damping = 0.15,
      particle_gravity = -50,
      min_distance_emit_particles = 0,
    },
  },

  {
    'f4z3r/gruvbox-material.nvim',
    name = 'gruvbox-material',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  'mg979/vim-visual-multi',

  -- File tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      enable_preview = true,

      filesystem = {
        -- open images (and anything else) externally
        commands = {
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id() -- absolute path
            vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
          end,
        },
        window = {
          mappings = {
            ['P'] = 'toggle_preview',
            ['O'] = 'system_open', -- press O to open with external viewer
          },
        },

        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = { '.git', '.elc' },
          hide_by_pattern = { '*.uid', 'node_modules' },
        },
      },
    },
  },

  -- LAZY PLUGIN SPEC (replace bufferline with barbar)
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim', -- optional, for git status icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = true,
      auto_hide = false,
      tabpages = false, -- show buffers, not Vim tabpages
      clickable = true,
      icons = {
        preset = 'slanted',
        button = '󰅖',
      },

      -- Treat neo-tree as a sidebar so it doesn't become a "tab" and layout stays sane
      sidebar_filetypes = {
        ['neo-tree'] = { event = 'BufWipeout' },
      },
    },
  },

  'nvim-tree/nvim-web-devicons',

  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  -- Flash (treesitter features removed)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      -- NOTE: removed: flash.treesitter(), flash.treesitter_search()
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        signs = {
          error = '',
          warning = '',
          hint = '',
          information = '',
          other = '﫠',
        },
      }
    end,
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function get_venv()
        local venv = vim.env.VIRTUAL_ENV
        if venv then
          local env = string.match(venv, '[^/]+$')
          return ' ' .. env
        end
        return ''
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
          lualine_x = { { get_venv }, 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  { 'nvim-pack/nvim-spectre', opts = {} },

  {
    'lukas-reineke/indent-blankline.nvim',
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

  -- Tooling installer
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'clangd',
        'clang-format',
        'codelldb',
        'cpplint',
        'cpptools',
        'csharpier',
        'csharp-language-server',
        'lua-language-server',
        'netcoredbg',
        'omnisharp',
        'omnisharp-mono',
        'prettier',
        'ruff',
        'rust-analyzer',
        'sonarlint-language-server',
        'stylua',
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Terminal UX
  {
    'akinsho/toggleterm.nvim',
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
          highlights = { border = 'Normal', background = 'Normal' },
        },
      }

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.diagnostic.disable(0)
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      end
      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new {
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        float_opts = { width = vim.o.columns, height = vim.o.lines },
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.diagnostic.disable(0)
          vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
          if vim.fn.mapcheck('<esc>', 't') ~= '' then
            vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
          end
        end,
      }

      function _G._lazygit_toggle()
        lazygit.dir = vim.fn.expand '%:p:h'
        lazygit:toggle()
      end

      local python = Terminal:new {
        cmd = 'ipython3',
        direction = 'horizontal',
        hidden = true,
        hidden_numbers = true,
      }
      function _G._python_toggle()
        python:toggle()
      end

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
              win_options = { sidescrolloff = 10 },
              insert_only = false,
            }
          end,
        },
      }
    end,
  },

  { 'navarasu/onedark.nvim', priority = 1000 },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'benfowler/telescope-luasnip.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
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
          path_display = { truncate = 3 },
          mappings = {
            i = {
              ['<C-t>'] = actions.select_tab,
              ['<C-v>'] = actions.select_vertical,
              ['<C-x>'] = actions.select_horizontal,
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
            find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
            follow = true,
          },
          lsp_document_symbols = { show_line = true },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'luasnip'
      require('telescope').load_extension 'live_grep_args'
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {
            notification = {
              window = {
                normal_hl = 'Comment',
                border = 'rounded',
                zindex = 45,
                max_width = 0,
                max_height = 0,
                x_padding = 1,
                y_padding = 0,
                align = 'bottom',
                relative = 'editor',
              },
            },
          }
        end,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('personal-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('T', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

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

      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
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
                library = { '${3rd}/luv/library', unpack(vim.api.nvim_get_runtime_file('', true)) },
              },
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim', 'require' } },
            },
          },
        },
        rust_analyzer = {},
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.offsetEncoding = { 'utf-16' }
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

      require('mason').setup { ui = { border = 'rounded' } }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'clangd',
          'lua_ls',
          'pyright',
          'ruff',
          'codelldb',
          'cpptools',
          'cpplint',
          'stylua',
          'prettier',
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
      }

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
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

      function _G.leave_snippet()
        if
          ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
        then
          require('luasnip').unlink_current()
        end
      end
      vim.api.nvim_command [[ autocmd ModeChanged * lua leave_snippet() ]]

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

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, {
          { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
        }),
      })

      require('lspconfig.ui.windows').default_options.border = 'rounded'
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

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
        virtual_text = { prefix = '●' },
        severity_sort = true,
        float = { source = 'always' },
        signs = true,
      }
    end,
  },

  -- Formatter
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          json = { { 'prettierd', 'prettier' } },
          lua = { 'stylua' },
          markdown = { 'prettier' },
          python = function(bufnr)
            if require('conform').get_formatter_info('ruff_format', bufnr).available then
              return { 'ruff_format' }
            end
            return { 'isort', 'black' }
          end,
          yaml = { 'prettier' },
          rust = { 'rustfmt' },
          ['*'] = { 'injected' },
        },
        ignore_errors = true,
        -- NOTE: removed treesitter mapping; keep only what you need
        lang_to_ext = {
          bash = 'sh',
          latex = 'tex',
          markdown = 'md',
          python = 'py',
        },
      }

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

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip/loaders/from_vscode').lazy_load {
        paths = { vim.fn.stdpath 'config' .. '/snippets' },
      }
    end,
  },

  {
    'Kurama622/llm.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
    cmd = { 'LLMSessionToggle', 'LLMSelectedTextHandler', 'LLMAppHandler' },
    config = function()
      require('llm').setup {
        -- GitHub Models (Azure inference)
        url = 'https://api.openai.com/v1/chat/completions',
        api_type = 'openai',

        -- Set this to what you want to use (must support /chat/completions)
        model = _G.chatgpt_model or 'gpt-5-nano',

        -- Sensible coding defaults
        --max_tokens = 4095,
        --temperature = 0.2,
        --top_p = 0.1,

        -- Keep it code-focused
        prompt = 'You are a helpful programming assistant. Be concise, show code when needed, and prefer practical fixes.',
        -- Visual selection -> context prompt
        selected_text_handler = {
          prompt = function(selection)
            return string.format(
              'You are a helpful programming assistant.\n\n' .. 'Context (selected text):\n' .. '```text\n%s\n```\n\n' .. 'Task:\n',
              selection
            )
          end,
        },

        -- Optional cosmetics (minimal)
        spinner = {
          text = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          hl = 'Title',
        },
        prefix = {
          user = { text = 'You: ', hl = 'Title' },
          assistant = { text = 'AI:  ', hl = 'Added' },
        },

        -- Persist chat history
        save_session = true,
        max_history = 30,
        max_history_name_length = 40,

        -- Keymaps inside the session UI
        keys = {
          -- Input window
          ['Input:Submit'] = { mode = 'i', key = '<cr>' }, -- Enter sends (your issue)
          ['Input:Cancel'] = { mode = { 'n', 'i' }, key = '<C-c>' },
          ['Input:Resend'] = { mode = { 'n', 'i' }, key = '<C-r>' },

          -- History (only if save_session=true)
          ['Input:HistoryNext'] = { mode = { 'n', 'i' }, key = '<C-j>' },
          ['Input:HistoryPrev'] = { mode = { 'n', 'i' }, key = '<C-k>' },

          -- Output window ("split" style)
          ['Output:Ask'] = { mode = 'n', key = 'i' },
          ['Output:Cancel'] = { mode = 'n', key = '<C-c>' },
          ['Output:Resend'] = { mode = 'n', key = '<C-r>' },

          -- Session window ("float" style)
          ['Session:Toggle'] = { mode = 'n', key = '<leader>ai' }, -- your chosen toggle
          ['Session:Close'] = { mode = 'n', key = { '<esc>', 'Q' } },
        },

        -- Optional diff display used by some tools/handlers
        display = {
          diff = {
            layout = 'vertical',
            opts = {
              'internal',
              'filler',
              'closeoff',
              'algorithm:patience',
              'followwrap',
              'linematch:120',
            },
            provider = 'mini_diff',
            disable_diagnostic = true,
          },
        },

        callbacks = {
          on_response = function(resp)
            local usage = resp and resp.usage
            if usage then
              vim.notify(
                string.format(
                  'LLM tokens — prompt: %d, completion: %d, total: %d',
                  usage.prompt_tokens or 0,
                  usage.completion_tokens or 0,
                  usage.total_tokens or 0
                ),
                vim.log.levels.INFO
              )
            end
          end,
        },

        -- If you later add tools:
        app_handler = {
          -- Visual-select text -> run this -> output in a floating result window.
          AskWithContext = {
            handler = 'attach_to_chat_handler',
            prompt = [[
              Answer the user’s question (likely code related) using the context very briefly and concisely: 
            ]],
            opts = {
              -- this is the key part: append the visual selection after the prompt
              apply_visual_selection = true, -- described in docs for flexi_handler :contentReference[oaicite:2]{index=2}
              is_codeblock = true,
              enter_input = true,
              enter_flexible_window = false,
              --exit_on_move = true,
            },
          },
          CodeExplain = {
            handler = 'flexi_handler',
            prompt = 'Explain the following code very briefly, please only return the explanation',
            opts = {
              enter_flexible_window = true,
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ai', '<cmd>LLMSessionToggle<cr>', mode = 'n', silent = true, desc = 'LLM: toggle session' },
      { '<leader>as', '<cmd>LLMSelectedTextHandler<cr>', mode = 'x', silent = true, desc = 'LLM: send selection' },
      -- If you add tools:
      { '<leader>ax', '<cmd>LLMAppHandler CodeExplain<cr>', mode = 'x', silent = true, desc = 'LLM tool: Explain' },
      { '<leader>ai', '<cmd>LLMAppHandler AskWithContext<cr>', mode = 'x', silent = true, desc = 'LLM tool: Ask with context' },
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        config = function()
          vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'llm', 'markdown' },
            callback = function()
              vim.treesitter.start(0, 'markdown')
            end,
          })
        end,
      },
      'nvim-mini/mini.icons',
    }, -- if you use standalone mini plugins
    ft = { 'markdown', 'llm' },

    config = function()
      require('render-markdown').setup {
        restart_highlighter = true,
        heading = {
          enabled = true,
          sign = false,
          position = 'overlay', -- inline | overlay
          icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
          signs = { '󰫎 ' },
          width = 'block',
          left_margin = 0,
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = false,
          border_virtual = false,
          border_prefix = false,
          above = '▄',
          below = '▀',
          backgrounds = {},
          foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
          },
        },
        dash = {
          enabled = true,
          icon = '─',
          width = 0.5,
          left_margin = 0.5,
          highlight = 'RenderMarkdownDash',
        },
        code = { style = 'normal' },
      }
    end,
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup { library = { plugins = { 'nvim-dap-ui' }, types = true } }

      local dap = require 'dap'
      local sign = vim.fn.sign_define

      sign('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      sign('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      sign('DapLogPoint', { text = '◆ ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      sign('DapStoppedLine', { text = '󰁕 ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      sign('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.expand '$HOME/.local/share/nvim/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

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
          name = 'C++: Attach to process',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
        },
      }

      require('dapui').setup {
        controls = { icons = { pause = '⏸ ', play = '▶ ', terminate = '⏹ ' } },
        floating = { border = 'rounded' },
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
            elements = { { id = 'console', size = 0.50 }, { id = 'repl', size = 0.50 } },
            position = 'bottom',
            size = 10,
          },
        },
      }

      require('nvim-dap-virtual-text').setup()
      require('dap-python').setup()
      require('dap-python').test_runner = 'pytest'

      vim.api.nvim_create_user_command('DapUIToggle', ":lua require('dapui').toggle()", {})
      vim.api.nvim_create_user_command('DapPytestMethod', ":lua require('dap-python').test_method()", {})
      vim.api.nvim_create_user_command('DapResetUI', ":lua require('dapui').open({reset = true})", { desc = 'Reset DAP UI Layout' })
    end,
  },
}, {})

-- =========================================
-- ============ START SMEAR PROFILE ========
-- =========================================
local smear = require 'smear_cursor'

local smear_profiles = {
  silver_blade = {
    -- General
    cursor_color = '#ffe6b2',
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    min_horizontal_distance_smear = 0,
    min_vertical_distance_smear = 0,
    smear_horizontally = true,
    smear_vertically = true,
    smear_diagonally = true,
    smear_to_cmd = true,
    scroll_buffer_space = true,

    legacy_computing_symbols_support = false,
    legacy_computing_symbols_support_vertical_bars = false,
    use_diagonal_blocks = true,

    vertical_bar_cursor = false,
    smear_insert_mode = true,
    vertical_bar_cursor_insert_mode = true,
    smear_replace_mode = false,
    smear_terminal_mode = false,
    horizontal_bar_cursor_replace_mode = true,

    never_draw_over_target = false,
    hide_target_hack = false,

    max_kept_windows = 50,
    windows_zindex = 300,
    filetypes_disabled = {},

    -- High FPS (smooth)
    time_interval = 7,
    delay_disable = nil,
    delay_event_to_smear = 1,
    delay_after_key = 6,

    -- Physics: fast head, laggy tail, smooth decay
    stiffness = 0.95,
    trailing_stiffness = 0.33,
    anticipation = 0.06,
    damping = 0.90,
    trailing_exponent = 5.5,
    distance_stop_animating = 0.06,

    -- Insert mode: match feel
    stiffness_insert_mode = 0.95,
    trailing_stiffness_insert_mode = 0.7,
    damping_insert_mode = 0.92,
    trailing_exponent_insert_mode = 5.5,
    distance_stop_animating_vertical_bar = 0.25,

    -- Diagonal + shading tuned for “pretty”
    max_slope_horizontal = (1 / 3) / 1.7,
    min_slope_vertical = 2 * 1.7,
    max_angle_difference_diagonal = math.pi / 18,
    max_offset_diagonal = 0.18,
    min_shade_no_diagonal = 0.22,
    min_shade_no_diagonal_vertical_bar = 0.55,

    -- Rich blending (costly but nice)
    color_levels = 24,
    gamma = 2.2,
    gradient_exponent = 2.8,
    max_shade_no_matrix = 0.78,
    matrix_pixel_threshold = 0.72,
    matrix_pixel_threshold_vertical_bar = 0.28,
    matrix_pixel_min_factor = 0.55,
    volume_reduction_exponent = 0.22,
    minimum_volume_factor = 0.78,

    -- Longer trail
    max_length = 34,
    max_length_insert_mode = 2,

    -- Particles off
    particles_enabled = false,
    particle_max_num = 100,
    particle_spread = 0.5,
    particles_per_second = 200,
    particles_per_length = 1.0,
    particle_max_lifetime = 300,
    particle_lifetime_distribution_exponent = 5,
    particle_max_initial_velocity = 10,
    particle_velocity_from_cursor = 0.2,
    particle_random_velocity = 100,
    particle_damping = 0.2,
    particle_gravity = 20,
    min_distance_emit_particles = 1.5,
    particle_switch_octant_braille = 0.3,
    particles_over_text = false,
  },
  -- 1) Frost Mist
  eco_smear = {
    -- General (keep core behavior)
    cursor_color = '#ffe6b2',
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    min_horizontal_distance_smear = 1, -- reduces tiny smears
    min_vertical_distance_smear = 1,
    smear_horizontally = true,
    smear_vertically = true,
    smear_diagonally = false, -- big CPU win
    smear_to_cmd = true,
    scroll_buffer_space = false, -- cheaper on scroll

    legacy_computing_symbols_support = false,
    legacy_computing_symbols_support_vertical_bars = false,
    use_diagonal_blocks = true,

    vertical_bar_cursor = false,
    smear_insert_mode = true,
    vertical_bar_cursor_insert_mode = true,
    smear_replace_mode = false,
    smear_terminal_mode = false,
    horizontal_bar_cursor_replace_mode = true,

    never_draw_over_target = false,
    hide_target_hack = false,

    max_kept_windows = 20, -- fewer render windows kept
    windows_zindex = 300,
    filetypes_disabled = {},

    -- Lower FPS (much cheaper)
    time_interval = 14,
    delay_disable = nil,
    delay_event_to_smear = 2,
    delay_after_key = 10,

    -- Physics: still fast head, shorter/cheaper tail
    stiffness = 0.90,
    trailing_stiffness = 0.28,
    anticipation = 0.04,
    damping = 0.88,
    trailing_exponent = 3.0,
    distance_stop_animating = 0.12,

    -- Insert mode: keep it tight
    stiffness_insert_mode = 0.90,
    trailing_stiffness_insert_mode = 0.28,
    damping_insert_mode = 0.90,
    trailing_exponent_insert_mode = 3.0,
    distance_stop_animating_vertical_bar = 0.30,

    -- Simpler shading (cheaper)
    max_slope_horizontal = (1 / 3) / 1.6,
    min_slope_vertical = 2 * 1.6,
    max_angle_difference_diagonal = math.pi / 16,
    max_offset_diagonal = 0.2,
    min_shade_no_diagonal = 0.30,
    min_shade_no_diagonal_vertical_bar = 0.60,

    -- Reduced blending cost
    color_levels = 16,
    gamma = 2.2,
    gradient_exponent = 1.3,
    max_shade_no_matrix = 0.80,
    matrix_pixel_threshold = 0.80,
    matrix_pixel_threshold_vertical_bar = 0.35,
    matrix_pixel_min_factor = 0.65,
    volume_reduction_exponent = 0.35,
    minimum_volume_factor = 0.82,

    -- Shorter trail
    max_length = 18,
    max_length_insert_mode = 1,

    -- Particles off
    particles_enabled = false,
    particle_max_num = 100,
    particle_spread = 0.5,
    particles_per_second = 200,
    particles_per_length = 1.0,
    particle_max_lifetime = 300,
    particle_lifetime_distribution_exponent = 5,
    particle_max_initial_velocity = 10,
    particle_velocity_from_cursor = 0.2,
    particle_random_velocity = 100,
    particle_damping = 0.2,
    particle_gravity = 20,
    min_distance_emit_particles = 1.5,
    particle_switch_octant_braille = 0.3,
    particles_over_text = false,
  },
}

-- smear settings
local smear_profile_order = {
  'silver_blade',
  'eco_smear',
}

local current_idx = 1

local function apply_smear_profile(name)
  local p = smear_profiles[name]
  if not p then
    vim.notify('Unknown smear profile: ' .. tostring(name), vim.log.levels.ERROR)
    return
  end
  smear.setup(vim.deepcopy(p))
  vim.g.smear_cursor_profile = name
  vim.notify('smear-cursor → ' .. name)
end

-- Commands
vim.api.nvim_create_user_command('SmearProfile', function(opts)
  apply_smear_profile(opts.args)
end, {
  nargs = 1,
  complete = function()
    return smear_profile_order
  end,
})
-- Apply a default on startup (pick one)
apply_smear_profile 'silver_blade'

vim.api.nvim_create_user_command('SmearProfileNext', function()
  current_idx = (current_idx % #smear_profile_order) + 1
  apply_smear_profile(smear_profile_order[current_idx])
end, {})

vim.api.nvim_create_user_command('SmearProfilePrev', function()
  current_idx = ((current_idx - 2) % #smear_profile_order) + 1
  apply_smear_profile(smear_profile_order[current_idx])
end, {})

-- Keybindings (edit if you want)
vim.keymap.set('n', '<leader>pn', '<cmd>SmearProfileNext<CR>', { desc = 'Smear profile: next' })
vim.keymap.set('n', '<leader>pp', '<cmd>SmearProfilePrev<CR>', { desc = 'Smear profile: prev' })

-- =========================================
-- ============ END SMEAR PROFILE ==========
-- =========================================

-- =========================
-- Editor settings
-- =========================
vim.o.hlsearch = false
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.wo.signcolumn = 'yes'
vim.opt.signcolumn = 'yes:1'
vim.opt.cursorline = true
vim.opt.colorcolumn = '100'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.listchars = { trail = '⇲', tab = '◦ ' }
vim.opt.list = true
vim.opt.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.opt.termguicolors = true

-- ============================
-- ====== TABSTOP START =======
-- ============================
local function set_indent(ts)
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = ts
  vim.opt_local.shiftwidth = ts
  vim.opt_local.softtabstop = ts
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'javascript', 'typescript', 'tsx', 'json', 'yaml', 'toml', 'html', 'css' },
  callback = function()
    set_indent(2)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'sh', 'bash', 'zsh', 'go', 'rust', 'cpp', 'c' },
  callback = function()
    set_indent(4)
  end,
})

-- Makefiles must use real tabs
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'make' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
  end,
})
-- ============================
-- ====== TABSTOP END =========
-- ============================

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local numtogGrp = vim.api.nvim_create_augroup('NumberToggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'FocusGained' }, {
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = true
  end,
  group = numtogGrp,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter', 'FocusLost' }, {
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = false
  end,
  group = numtogGrp,
})

-- =========================
-- Keymaps (treesitter keymaps removed)
-- =========================

-- scrolling / search centering, disabled for neoscroll
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center cursor' })
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center cursor' })
-- vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
-- vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-W>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-W>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-W>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-W>l', { desc = 'Go to right window' })

-- clipboard / yank
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting register' })
vim.keymap.set('n', '<leader>ya', ':%y+<CR>', { desc = 'Yank entire buffer to clipboard' })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable, { desc = 'Disable diagnostics' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.enable, { desc = 'Enable diagnostics' })

-- misc
vim.keymap.set('n', '<leader>cw', ':cd %:p:h<CR>:pwd<CR>', { desc = 'cd to current file directory' })
vim.keymap.set('n', '<C-I>', '<C-I>', { noremap = true, desc = 'Jump forward in jumplist' })
vim.keymap.set('n', '<C-s>', ':write<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', ':write<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>cd', ':ToggleAutoComplete<CR>', { desc = 'Toggle autocomplete' })
vim.keymap.set('n', '<leader>ce', ':ToggleAutoComplete<CR>', { desc = 'Toggle autocomplete (alias)' })

-- Telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'List open buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
    sorting_strategy = 'ascending',
  })
end, { desc = 'Fuzzy search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search word under cursor' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').spell_suggest, { desc = 'Spell suggestions' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').git_commits, { desc = 'Search git commits' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Resume last Telescope picker' })

vim.keymap.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = 'Live grep in open files' })

vim.keymap.set('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Search Neovim config files' })

-- run / permissions
vim.keymap.set('n', '<leader>ru', ':w<CR>:!%:p', { desc = 'Save and run current file' })
vim.keymap.set('n', '<leader>me', ':!chmod +x %:p<CR>', { desc = 'Make file executable' })
vim.keymap.set('n', '<leader>P', require('spectre').open, { desc = 'Open Spectre search/replace' })

-- Trouble
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble' })
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true, desc = 'Workspace diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true, desc = 'Document diagnostics (Trouble)' })

-- DAP
vim.keymap.set('n', '<leader>dap', ":lua require('dapui').toggle()<CR>", { desc = 'Toggle DAP UI' })
vim.keymap.set('n', '<leader>dc', ":lua require('dap').continue()<CR>", { desc = 'DAP continue' })
vim.keymap.set('n', '<leader>do', ":lua require('dap').step_over()<CR>", { desc = 'DAP step over' })
vim.keymap.set('n', '<leader>di', ":lua require('dap').step_into()<CR>", { desc = 'DAP step into' })
vim.keymap.set('n', '<leader>dk', function()
  require('dap.ui.widgets').hover()
end, { desc = 'DAP hover value' })
vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end, { desc = 'DAP scopes' })
vim.keymap.set('n', '<leader>du', ":lua require('dap').step_out()<CR>", { desc = 'DAP step out' })
vim.keymap.set('n', '<leader>dl', ":lua require('dapui').float_element()<CR>", { silent = true, noremap = true, desc = 'DAP floating window' })
vim.keymap.set('n', '<leader>dt', ":lua require('dap').toggle_breakpoint()<CR>", { silent = true, noremap = true, desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dm', ":lua require('dap-python').test_method()<CR>", { silent = true, noremap = true, desc = 'DAP test method' })
vim.keymap.set('n', '<leader>df', ":lua require('dap-python').test_class()<CR>", { silent = true, noremap = true, desc = 'DAP test class' })

-- bufferline

local opts = { noremap = true, silent = true }

-- KEYMAPS (Barbar)
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 1' }))
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 2' }))
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 3' }))
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 4' }))
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 5' }))
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 6' }))
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 7' }))
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 8' }))
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 9' }))
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', vim.tbl_extend('force', opts, { desc = 'Go to last buffer' }))
-- Close current buffer (Barbar)
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>', vim.tbl_extend('force', opts, { desc = 'Close buffer' }))

-- Close current window/split
vim.keymap.set('n', '<A-q>', '<Cmd>close<CR>', vim.tbl_extend('force', opts, { desc = 'Close window' }))

vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { desc = 'Go to previous buffer' })

-- barbar colors

-- quickfix
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>cp', ':cprevious<CR>', { desc = 'Previous quickfix item' })

-- markdown
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Markdown preview' })

-- git
vim.keymap.set('n', '<leader>ga', ':Telescope coauthors<CR>', { desc = 'Select git co-authors' })

-- delete backwards
vim.keymap.set({ 'i', 'c' }, '<C-BS>', '<C-w>', { noremap = true, desc = 'Delete previous word' })

vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>fk', ':FloatermKill!<CR>', { desc = 'Kill all floaterm terminals' })
vim.keymap.set('x', 'S', '<Plug>(nvim-surround-visual)', { remap = true }, { desc = 'Surround selected text' })

-- yank binding
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true })

-- exit and save
vim.keymap.set('n', '<C-w>', '<cmd>wqa<cr>')

-- split views
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>')

-- toggle neotree
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
_G.toggle_neotree = toggle_neotree
vim.api.nvim_set_keymap('n', '<C-n>', ':lua toggle_neotree()<CR>', { noremap = true, silent = true })

-- Floaterm
vim.api.nvim_set_keymap('n', '<C-`>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-`>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-`>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

-- Comment.nvim keymaps
vim.api.nvim_set_keymap('n', '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-/>', '<cmd>lua require("Comment.api").toggle.blockwise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-/>', '<ESC><cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true })

-- git coauthors
vim.keymap.set('n', '<leader>ga', ':Telescope coauthors<CR>')

-- install treesitter parsers
require('nvim-treesitter').install { 'c', 'rust', 'gdscript', 'c_sharp' }

-- ======== LSP settings ===========
-- signature help
vim.api.nvim_set_keymap('i', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
-- code actions (normal + insert)
vim.keymap.set({ 'n', 'i' }, '<C-.>', vim.lsp.buf.code_action, { silent = true, desc = 'Code Action' })
-- rename bindings
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { silent = true, desc = 'LSP: Rename' })
vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, { silent = true, desc = 'LSP: Go To Defintion' })

-- put after colorscheme load
vim.api.nvim_set_hl(0, '@lsp.type.typeAlias', { link = 'Type' })
vim.api.nvim_set_hl(0, '@lsp.type.type', { link = 'Type' })
vim.api.nvim_set_hl(0, '@lsp.type.struct', { link = 'Type' })
