-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- {
  --   -- there are other options that are able to be set such as diagnostics.
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   opts = {},
  -- },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'ThePrimeagen/vim-be-good',
  },
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'Pocco81/auto-save.nvim',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
  },
  {
    'MunifTanjim/prettier.nvim',
  },
  {
    'mbbill/undotree',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        TODO = { icon = ' ', color = 'default', alt = { 'TODO: wcraig' } },
        FIXME = { icon = ' ', color = 'error', alt = { 'FIXME: wcraig' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'NOTE: wcraig' } },
        HACK = { icon = ' ', color = 'warning', alt = { 'HACK: wcraig' } },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARN: wcraig' } },
        PERF = { icon = ' ', color = 'hint', alt = { 'PERF: wcraig' } },
        LINK = { icon = ' ', color = 'info', alt = { 'LINK: wcraig' } },
        DEBUG = { icon = ' ', color = 'info', alt = { 'DEBUG: wcraig' } },
        DONE = { icon = '✔', color = 'info', alt = { 'DONE: wcraig' } },

        gui_style = {
          fg = 'NONE', -- The gui style to use for the fg highlight group.
          bg = 'BOLD', -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
          before = '', -- "fg" or "bg" or empty
          keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = 'fg', -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
          warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
          info = { 'DiagnosticInfo', '#2563EB' },
          hint = { 'DiagnosticHint', '#10B981' },
          default = { 'Identifier', '#7C3AED' },
          test = { 'Identifier', '#FF00FF' },
        },
        search = {
          command = 'rg',
          args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS): wcraig]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'mg979/vim-visual-multi',
  },
  {
    'ldelossa/gh.nvim',
    dependencies = {
      {
        'ldelossa/litee.nvim',
        config = function()
          require('litee.lib').setup()
        end,
      },
    },
    config = function()
      require('litee.gh').setup()
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  -- {
  --   'dgagn/diagflow.nvim',
  --   -- event = 'LspAttach', This is what I use personnally and it works great
  --   opts = {},
  -- },

  {
    'lewis6991/hover.nvim',
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require 'hover.providers.lsp'
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.fold_preview')
          -- require('hover.providers.diagnostic')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'single',
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'LSP',
        },
        mouse_delay = 1000,
      }

      -- Setup keymaps
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
      vim.keymap.set('n', '<C-p>', function()
        require('hover').hover_switch 'previous'
      end, { desc = 'hover.nvim (previous source)' })
      vim.keymap.set('n', '<C-n>', function()
        require('hover').hover_switch 'next'
      end, { desc = 'hover.nvim (next source)' })

      -- Mouse support
      vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
      vim.o.mousemoveevent = true
      -- end)
    end,
  },
  {
    'VidocqH/lsp-lens.nvim',
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'OlegGulevskyy/better-ts-errors.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = {
      keymaps = {
        toggle = '<leader>dd', -- default '<leader>dd'
        go_to_definition = '<leader>dx', -- default '<leader>dx'
      },
    },
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'

      local logo = [[
__________________/\/\____/\/\____/\/\__________________________________/\/\___________________
_/\/\______/\/\__________/\/\____/\/\__________/\/\/\/\____/\/\__/\/\__________/\/\/\__/\/\___ 
_/\/\__/\__/\/\__/\/\____/\/\____/\/\__________/\/\__/\/\__/\/\__/\/\__/\/\____/\/\/\/\/\/\/\_  
_/\/\/\/\/\/\/\__/\/\____/\/\____/\/\____/\/\__/\/\__/\/\____/\/\/\____/\/\____/\/\__/\__/\/\_   
___/\/\__/\/\____/\/\/\__/\/\/\__/\/\/\__/\/\__/\/\__/\/\______/\______/\/\/\__/\/\______/\/\_    
______________________________________________________________________________________________     

 ]]
      --       local logo = [[
      --  █     █░ ██▓ ██▓     ██▓          ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓
      -- ▓█░ █ ░█░▓██▒▓██▒    ▓██▒          ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒
      -- ▒█░ █ ░█ ▒██▒▒██░    ▒██░         ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░
      -- ░█░ █ ░█ ░██░▒██░    ▒██░         ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██
      -- ░░██▒██▓ ░██░░██████▒░██████▒ ██▓ ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒
      -- ░ ▓░▒ ▒  ░▓  ░ ▒░▓  ░░ ▒░▓  ░ ▒▓▒ ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░
      --   ▒ ░ ░   ▒ ░░ ░ ▒  ░░ ░ ▒  ░ ░▒  ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░
      --   ░   ░   ▒ ░  ░ ░     ░ ░    ░      ░   ░ ░     ░░   ▒ ░░      ░
      --     ░     ░      ░  ░    ░  ░  ░           ░      ░   ░         ░
      --                                ░                 ░
      --
      --
      --
      --
      --
      --
      --
      --
      --
      --
      -- ]]
      dashboard.section.header.val = vim.split(logo, '\n')

        -- stylua: ignore
        dashboard.section.buttons.val = {
        dashboard.button("r", "Recent", "<cmd> Telescope oldfiles <cr>"),
        dashboard.button('f', 'Find File', '<cmd>Telescope find_files<cr>'),
        dashboard.button('l', "Lazygit", "<cmd>TermExec cmd='lazygit'<cr>"),
        dashboard.button('R', 'Restore Session', '<cmd>SessionRestore<cr>'),
        dashboard.button("q", " Quit", "<cmd> qa <cr>")
        }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'Comment'
        button.opts.hl_shortcut = ''
        button.opts.position = 'center'
        button.opts.width = 25
      end
      dashboard.section.header.opts.hl = ''
      dashboard.section.footer.opts.hl = 'Keyword'
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,

    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          once = true,
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()
          -- Get the current date and time

          -- Get the current hour
          local current_hour = tonumber(os.date '%H')

          -- Define the greeting variable
          local greeting

          if current_hour < 5 then
            greeting = '    Good night!'
          elseif current_hour < 12 then
            greeting = '  󰼰 Good morning!'
          elseif current_hour < 17 then
            greeting = '    Good afternoon!'
          elseif current_hour < 20 then
            greeting = '  󰖝  Good evening!'
          else
            greeting = '  󰖔  Good night!'
          end

          dashboard.section.footer.val = greeting

          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  { 'dmmulroy/ts-error-translator.nvim' },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  { 'artemave/workspace-diagnostics.nvim' },

  {
    'nvimtools/none-ls.nvim',
  },
  { 'dmmulroy/tsc.nvim' },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  { 'gorbit99/codewindow.nvim' },
  { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },
  { 'moll/vim-bbye' },
  -- { 'yioneko/nvim-vtsls'},
  {
    'askfiy/lsp_extra_dim',
    event = { 'LspAttach' },
    config = function()
      require('lsp_extra_dim').setup()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'thenbe/neotest-playwright',
      dependencies = 'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require('neotest-playwright').adapter {
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          },
        },
      }
    end,
  },
  {
    'MysticalDevil/inlay-hints.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('inlay-hints').setup()
    end,
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    opts = {},
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
}
