vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
  -- Git
  'voldikss/vim-floaterm',

  'tpope/vim-fugitive',

  'rhysd/conflict-marker.vim',

  { 'kylechui/nvim-surround', config = true },

  { 'numToStr/Comment.nvim', opts = {} },

  'rhysd/git-messenger.vim',
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

  -- Colors
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox-material'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'sphamba/smear-cursor.nvim',
  opts = {                                -- Default  Range
    stiffness = 0.6,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.4,             -- 0.45     [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.8,                       -- 0.85     [0, 1]
    damping_insert_mode = 0.8,           -- 0.9      [0, 1]
    distance_stop_animating = 0.1,        -- 0.1      > 0
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
      filesystem = {
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

  -- Buffers/tabs
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
    'romgrk/barbar.nvim',
    event = 'BufEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    lazy = true,
  },

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
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
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
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>ya', ':%y+<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable)
vim.keymap.set('n', '<leader>de', vim.diagnostic.enable)

vim.keymap.set('n', '<leader>cw', ':cd %:p:h<CR>:pwd<CR>')
vim.keymap.set('n', '<C-I>', '<C-I>', { noremap = true })
vim.keymap.set('n', '<C-s>', ':write<CR>')
vim.keymap.set('n', '<leader>cd', ':ToggleAutoComplete<CR>')
vim.keymap.set('n', '<leader>ce', ':ToggleAutoComplete<CR>')

-- Telescope keymaps
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
    sorting_strategy = 'ascending',
  })
end)

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').spell_suggest)
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps)
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files)
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').git_commits)
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume)
vim.keymap.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end)
vim.keymap.set('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end)

vim.keymap.set('n', '<leader>ru', ':w<CR>:!%:p')
vim.keymap.set('n', '<leader>me', ':!chmod +x %:p<CR>')
vim.keymap.set('n', '<leader>P', require('spectre').open)

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true })

-- DAP keymaps
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
vim.keymap.set('n', '<leader>dl', ":lua require('dapui').float_element()<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dt', ":lua require('dap').toggle_breakpoint()<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dm', ":lua require('dap-python').test_method()<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>df', ":lua require('dap-python').test_class()<CR>", { silent = true, noremap = true })

-- barbar
vim.keymap.set('n', '<A-,>', '<cmd>BufferPrevious<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-.>', '<cmd>BufferNext<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-c>', '<cmd>BufferClose<cr>', { silent = true, noremap = true })
local opts = { noremap = true, silent = true }
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

-- quickfix
vim.keymap.set('n', '<leader>cn', ':cnext<CR>')
vim.keymap.set('n', '<leader>cp', ':cprevious<CR>')

-- markdown
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>')

-- git coauthors
vim.keymap.set('n', '<leader>ga', ':Telescope coauthors<CR>')

-- Comment.nvim keymaps
vim.api.nvim_set_keymap('n', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true })

-- Floaterm
vim.api.nvim_set_keymap('n', '<C-t>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-t>', ':FloatermToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

-- Neo-tree toggle
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

vim.api.nvim_set_keymap('i', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_augroup('EnsureTextWindowFocus', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'EnsureTextWindowFocus',
  callback = function()
    vim.defer_fn(function()
      vim.cmd 'wincmd p'
    end, 100)
  end,
})

vim.api.nvim_create_augroup('CppIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'c', 'cc', 'h', 'hpp' },
  group = 'CppIndent',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', '<cmd>wqa<cr>')

vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>')

-- AI wrapper
local ai_enabled = true
vim.keymap.set('n', '<leader>at', function()
  ai_enabled = not ai_enabled
  print(ai_enabled and 'AI enabled' or 'AI disabled')
end)

local function ai_safe(cmd)
  return function()
    if not ai_enabled then
      print 'AI is disabled'
      return
    end
    vim.cmd(cmd)
  end
end

vim.keymap.set('n', '<leader>ai', ai_safe 'ChatGPT')
vim.keymap.set('v', '<leader>ac', ai_safe 'ChatGPTEditWithInstruction')
vim.keymap.set('v', '<leader>ae', ai_safe 'ChatGPTExplain')

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>')
vim.keymap.set('n', '<leader>fk', ':FloatermKill!<CR>')

vim.keymap.set('x', 'S', '<Plug>(nvim-surround-visual)', { remap = true })
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true })
vim.keymap.set('c', '<C-BS>', '<C-w>', { noremap = true })

vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>')
