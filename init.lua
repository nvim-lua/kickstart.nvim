--  NOTE: Leader before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Margins
vim.opt.title = false -- in status, not great with tmux
vim.opt.number = true -- show line number
vim.opt.relativenumber = false
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.colorcolumn = '120'
-- vim.opt.breakindent = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.mouse = 'nvi'

-- File related
vim.opt.autochdir = false
vim.opt.writebackup = false
vim.opt.undofile = true
if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  vim.opt.fileformats = 'dos,unix,mac'
elseif vim.fn.has 'mac' == 1 then
  vim.opt.fileformats = 'mac,unix,dos'
else
  vim.opt.fileformats = 'unix,dos,mac'
end
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,list:full' -- list choices, expand singles
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open explorer [V]' })

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false
vim.opt.inccommand = 'split' -- preview

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Windows
-- :sp/:vsp to split windows
-- C-w to jump between them
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Spelling: "z=" in normal to suggest replacements
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = 'Toggle [D]iagnostics' })

-- Highlight when yanking (copying) text - "yap"
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install Lazy from Github
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- :Lazy
require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Emacs-style keybindings in insert mode
  {
    'millerjason/neovimacs.nvim',
    opts = {},
  },

  -- Add git changes to gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Shows keybindings as you go
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- Fuzzy finder (file & lsp)
  -- :Telescope help_tags
  -- See `:help telescope` and `:help telescope.setup()`
  -- To see keymaps do this:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
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
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find [F]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find [G]rep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find [B]uffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find [H]elp tags' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
    end,
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
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
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- :help CursorHold
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

          -- Inlay hints
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        pyright = {},
        black = {},
        isort = {},
        taplo = {},
        -- rust_analyzer = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      -- :Mason
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Auto-format
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'pyright', 'isort', 'black' },
        md = { 'prettier' },
      },
    },
  },

  -- Venv selector
  -- WIP: https://github.com/linux-cultist/venv-selector.nvim/tree/regexp
  -- Wait for a updated release

  -- Auto-completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Other completions
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          autocomplete = false, -- Use C-Space
          completeopt = 'menu,menuone,noinsert',
        },
        -- `:help ins-completion`
        mapping = cmp.mapping.preset.insert {
          ['<down>'] = cmp.mapping.select_next_item(),
          ['<up>'] = cmp.mapping.select_prev_item(),
          ['<left>'] = cmp.mapping.scroll_docs(-4),
          ['<right>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<C-g>'] = cmp.mapping.abort(),
          ['<C-h>'] = cmp.mapping.complete {},
          ['<C-right>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-left>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- Color scheme
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Small plugings
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Treesitter navigation
  -- :help nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'css',
        'cuda',
        'diff',
        'dockerfile',
        'dot',
        'go',
        'gomod',
        'html',
        'java',
        'javascript',
        'json',
        'json5',
        'latex',
        'llvm',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'nix',
        'python',
        'query',
        'rst',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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

-- Function to center current line vertically
--- C-l will recenter as well as refresh
local function recenter_vertically()
  local current_line = vim.fn.line '.'
  local window_height = vim.api.nvim_win_get_height(0)

  -- Calculate the ideal scroll position
  local scroll_offset = math.floor(window_height / 2)
  local target_top_line = math.max(1, current_line - scroll_offset)

  -- Set the window view
  vim.api.nvim_win_set_cursor(0, { current_line, 0 })
  vim.fn.winrestview { topline = target_top_line }
end
local function recenter_and_refresh()
  vim.cmd 'redraw!'
  recenter_vertically()
end
vim.keymap.set('n', '<C-l>', recenter_and_refresh, { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', recenter_and_refresh, { noremap = true, silent = true })
vim.keymap.set('c', '<C-s>', '<CR>n', { expr = true })

--- (Re)Undefine undesirable behavior
vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>', '<Nop>', { noremap = true })

-- Terminals/Shell
-- :terminal

-- Arrows keys for wildmenu
vim.keymap.set('c', '<Up>', 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Down>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Left>', 'pumvisible() ? "<C-b>" : "<Left>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Right>', 'pumvisible() ? "<C-f>" : "<Right>"', { expr = true, noremap = true })
-- vim.opt.wildcharm = '<Tab>' -- set wildcharm=<C-Z>

-- LSP in insert mode
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
})

-- Tab management keys
-- F1-Prev, F2-Next, F3-New, F4-Close
--
local function safe_tabclose()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call('win_findbuf', bufnr)
  local modified = vim.api.nvim_get_option_value('modified', { buf = bufnr })

  if vim.fn.tabpagenr '$' == 1 then
    -- last tab, no-op
    return
  elseif modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = 'Buffer modified, are you sure? ',
    }, function(input)
      if input == 'y' then
        vim.cmd 'tabclose'
      end
    end)
  else
    vim.cmd 'tabclose'
  end
end
vim.keymap.set('n', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('n', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('n', '<F3>', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('i', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('i', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('i', '<F3>', '<Esc>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '', '<Esc>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', vim.cmd.tabn, { desc = 'Tab [p]revious' })
vim.keymap.set('n', '<leader>tn', vim.cmd.tabp, { desc = 'Tab [n]ext' })
vim.keymap.set('n', '<leader>to', vim.cmd.tabnew, { desc = 'Tab [o]pen' })
vim.keymap.set('n', '<leader>tc', safe_tabclose, { desc = 'Tab [c]lose' })
