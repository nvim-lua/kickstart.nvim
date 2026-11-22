vim.g.python3_host_prog = vim.env.HOME .. '/.local/venv/nvim/bin/python'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '_', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('v', '_', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-w>z', '<cmd>WindowsMaximize<CR>')
vim.keymap.set('n', '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>')
vim.keymap.set('n', '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>')
vim.keymap.set('n', '<C-w>=', '<cmd>WindowsEqualize<CR>')
vim.keymap.set('n', ']w', '<cmd>bnext<CR>')
vim.keymap.set('n', '[w', '<cmd>bprev<CR>')
vim.keymap.set('n', ']q', '<cmd>cnext<CR>')
vim.keymap.set('n', '[q', '<cmd>cprev<CR>')
vim.keymap.set('n', '<leader>nb', ':%bd<CR><C-O>:bd#<CR><CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '10jzz')
vim.keymap.set('n', '<C-u>', '10kzz')
vim.keymap.set('n', 'n', 'nzzzv')


vim.opt.scroll = 10
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter',    dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    "hedyhli/outline.nvim",
    config = function()
      vim.keymap.set("n", "+", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
      }
    end,
  },
  {
    {
      'romgrk/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      },
      init = function() vim.g.barbar_auto_setup = false end,
      opts = {
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
          NvimTree = {
            text = 'filetree',
          },
          -- Or, specify the text used for the offset:
          undotree = {
            text = 'undotree',
          },
        },
      },
      version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
  },
  { 'windwp/nvim-autopairs',    event = 'InsertEnter', config = true },
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --   },
  --   build = 'make',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua',      -- for providers='copilot'
  --     {
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },
  { 'NvChad/nvim-colorizer.lua' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>r',
        function()
          require('conform').format { async = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        rust = { 'rustfmt' },
        sql = { 'sqlfluff' },
        javascript = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2' },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_RelativeTimestamp = 0
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_ShortIndicators = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 1
      vim.g.undotree_CursorLine = 1
      vim.g.undotree_HighlightChangedText = 1
      vim.g.undotree_HighlightChangedWithSign = 1
    end,
  },
  { 'akinsho/toggleterm.nvim',   version = '*',         config = true },
  { 'Joakker/lua-json5',         build = './install.sh' },
  { 'statico/vim-javascript-sql' },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        lightbulb = {
          enable = false,
        },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
  },
  { 'petertriho/nvim-scrollbar' },
  'nvim-treesitter/nvim-treesitter-context',
  'tpope/vim-sleuth',
  {
    'debugloop/telescope-undo.nvim',
    dependencies = { -- note how they're inverted to above example
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      { -- lazy style key map
        '<leader>su',
        '<cmd>Telescope undo<cr>',
        desc = 'undo history',
      },
    },
    opts = {
      extensions = {
        undo = {
        },
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension 'undo'
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  { 'ThePrimeagen/vim-apm' },
  { 'tpope/vim-dadbod' },
  { 'xiyaowong/telescope-emoji.nvim' },
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' } },
    opts = {
      snippets = { preset = 'luasnip' },
      -- ensure you have the `snippets` source (enabled by default)
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      }
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'saghen/blink.cmp',
    },
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = (function()
  --         if vim.fn.has 'win32' == 1 then
  --           return
  --         end
  --         return 'make install_jsregexp'
  --       end)(),
  --     },
  --
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-path',
  --     'rafamadriz/friendly-snippets',
  --   },
  -- },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {},
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        filters = { dotfiles = false, git_ignored = false },
        view = { adaptive_size = true },
        update_focused_file = { enable = true },
      }
    end,
  },
  { 'folke/which-key.nvim',  opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = { follow_files = true },
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = { virt_text = true, virt_text_pos = 'eol', delay = 1000, ignore_whitespace = false, virt_text_priority = 100 },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = { border = 'single', style = 'minimal', relative = 'cursor', row = 0, col = 1 },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = { barbar = true },
      color_overrides = {
        mocha = {
          base = "#0B1721",
          mantle = "#0E1B28",
          crust = "#000000",
        },
      },
    },
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        post_restore_cmds = nil,
        pre_save_cmds = nil,
      }
    end,
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'andrew-george/telescope-themes',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  { 'averms/black-nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
  },
  require 'kickstart.plugins.debug',
}, {})


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'horizon',
    component_separators = '|',
    section_separators = '',
    inactive_sections = {
      lualine_a = {},
      lualine_b = { 'filename' },
      lualine_x = { 'filetype' },
    },
  },
}

require 'kickstart.plugins.toggleterm-config'
require 'kickstart.plugins.debug'

local apm = require 'vim-apm'
apm:setup {}
vim.keymap.set('n', '<leader>apm', function()
  apm:toggle_monitor()
end)

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>m', function()
  if vim.lsp.inlay_hint then
    if vim.lsp.inlay_hint() then
      vim.lsp.inlay_hint(nil, false)
    else
      vim.lsp.inlay_hint(nil, true)
    end
  end
end)

vim.g.javascript_sql_dialect = 'mysql'
vim.g.tmux_navigator_no_wrap = 1

local rainbow_delimiters = require 'rainbow-delimiters'
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  priority = {
    [''] = 110,
    lua = 210,
  },
}

-- winborder (0.11+) borders hover, signature help, diagnostics floats and completion docs
vim.o.winborder = 'single'

vim.cmd.colorscheme = require("catppuccin").load()

vim.o.hlsearch = true
vim.o.incsearch = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.list = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamed'
vim.o.breakindent = false
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 300
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 50
vim.o.completeopt = 'menu,preview'
vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-q>', '<cmd>call Black()<CR>')

vim.api.nvim_set_keymap('n', '<space>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nt', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nh', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = true })
vim.api.nvim_set_hl(0, "TreesitterContextBottom", {
  bg = "#302D41", -- Same as above for consistency
})
vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", {
  bg = "#302D41", -- Same as above for consistency
  fg = "#6E6C7E"  -- Catppuccin overlay0 color
})
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require 'nvim-tree.api'
    local view = require 'nvim-tree.view'
    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

require('scrollbar').setup {
  providers = { gitsigns = true, search = true },
  scrollbar = { thumb = { highlight = { bg = 'black' } } },
}

require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'emoji')
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'themes')

local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == '' then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep { search_dirs = { git_root } }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>se', ':Telescope emoji<cr>', { desc = '[S]earch [E]mojis' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sU', ':UndotreeShow<cr>', { desc = '[S]earch [U]ndotree' })

-- nvim-treesitter `main` branch: parsers are installed explicitly (needs the `tree-sitter` CLI),
-- and highlighting/indent are enabled per-filetype with Neovim's built-in treesitter.
require('nvim-treesitter').install {
  'html', 'markdown', 'markdown_inline', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'sql', 'yaml',
  'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'query',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and pcall(vim.treesitter.start, args.buf, lang) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Incremental selection is built into Neovim 0.12: `an` / `in` in visual mode (:help v_an)

-- Textobjects (main branch API)
require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}
local ts_select = require 'nvim-treesitter-textobjects.select'
local ts_move = require 'nvim-treesitter-textobjects.move'
local ts_swap = require 'nvim-treesitter-textobjects.swap'
for key, query in pairs {
  aa = '@parameter.outer', ia = '@parameter.inner',
  af = '@function.outer', ['if'] = '@function.inner',
  ac = '@class.outer', ic = '@class.inner',
} do
  vim.keymap.set({ 'x', 'o' }, key, function() ts_select.select_textobject(query, 'textobjects') end)
end
for key, spec in pairs {
  [']m'] = { ts_move.goto_next_start, '@function.outer' },
  [']]'] = { ts_move.goto_next_start, '@class.outer' },
  [']M'] = { ts_move.goto_next_end, '@function.outer' },
  [']['] = { ts_move.goto_next_end, '@class.outer' },
  ['[m'] = { ts_move.goto_previous_start, '@function.outer' },
  ['[['] = { ts_move.goto_previous_start, '@class.outer' },
  ['[M'] = { ts_move.goto_previous_end, '@function.outer' },
  ['[]'] = { ts_move.goto_previous_end, '@class.outer' },
} do
  vim.keymap.set({ 'n', 'x', 'o' }, key, function() spec[1](spec[2], 'textobjects') end)
end
vim.keymap.set('n', '<leader>a', function() ts_swap.swap_next '@parameter.inner' end)
vim.keymap.set('n', '<leader>A', function() ts_swap.swap_previous '@parameter.inner' end)

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local opts = { noremap = true, silent = true }

  vim.api.nvim_set_keymap('n', '<leader>Rn', '<cmd>Lspsaga rename<CR>', opts)           -- Rename
  vim.api.nvim_set_keymap('n', '<leader>RN', '<cmd>Lspsaga rename<CR>', opts)           -- Rename
  vim.api.nvim_set_keymap('n', '<leader>CA', '<cmd>Lspsaga code_action<CR>', opts)      -- Code Action
  vim.api.nvim_set_keymap('n', '<leader>Ca', '<cmd>Lspsaga code_action<CR>', opts)      -- Code Action
  vim.api.nvim_set_keymap('n', 'go', '<cmd>Lspsaga outline<CR>', opts)                  -- Peek Definition
  vim.api.nvim_set_keymap('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)          -- Peek Definition
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>Lspsaga finder<CR>', opts)                   -- LSP Finder (includes references)
  nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  vim.api.nvim_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- Go to Implementation
  vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>Lspsaga type_definition<CR>', opts)   -- Type Definition
  vim.api.nvim_set_keymap('n', '<leader>ds', '<cmd>Lspsaga document_symbol<CR>', opts)  -- Document Symbols
  vim.api.nvim_set_keymap('n', '<leader>ws', '<cmd>Lspsaga workspace_symbol<CR>', opts) -- Workspace Symbols
  -- vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)                                  -- Hover Documentation
  nmap('gD', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)    -- Add Workspace Folder
  vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts) -- Remove Workspace Folder
  vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts)                                                                                                -- List Workspace Folders
  vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>',
    { desc = 'Go to previous diagnostic message', noremap = true, silent = true })
  vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>',
    { desc = 'Go to next diagnostic message', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>',
    { desc = 'Open floating diagnostic message', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>q', function()
    vim.diagnostic.setqflist { open = false, workspace = true }
    vim.cmd 'copen'
  end, { desc = 'Open Workspace diagnostics', noremap = true, silent = true })
end

require('which-key').add {
  { '<leader>c',  group = '[C]ode' },
  { '<leader>c_', hidden = true },
  { '<leader>d',  group = '[D]ocument' },
  { '<leader>d_', hidden = true },
  { '<leader>g',  group = '[G]it' },
  { '<leader>g_', hidden = true },
  { '<leader>h',  group = 'Git [H]unk' },
  { '<leader>h_', hidden = true },
  { '<leader>r',  group = '[R]ename' },
  { '<leader>r_', hidden = true },
  { '<leader>s',  group = '[S]earch' },
  { '<leader>s_', hidden = true },
  { '<leader>t',  group = '[T]oggle' },
  { '<leader>t_', hidden = true },
  { '<leader>w',  group = '[W]orkspace' },
  { '<leader>w_', hidden = true },
  { 't',          group = 'Toggle' },
  { 'tf',         '<cmd>ToggleTerm direction=float<cr>',              desc = 'Float' },
  { 'tg',         '<cmd>lua _LAZYGIT_TOGGLE()<cr>',                   desc = 'LazyGit' },
  { 'th',         '<cmd>ToggleTerm size=10 direction=horizontal<cr>', desc = 'Horizontal' },
  { 'tn',         '<cmd>lua _NODE_TOGGLE()<cr>',                      desc = 'Node' },
  { 'tp',         '<cmd>lua _PYTHON_TOGGLE()<cr>',                    desc = 'Python' },
  { 'tv',         '<cmd>ToggleTerm size=80 direction=vertical<cr>',   desc = 'Vertical' },
}

require('which-key').add {
  { '<leader>',  group = 'VISUAL <leader>', mode = 'v' },
  { '<leader>h', desc = 'Git [H]unk',       mode = 'v' },
}

local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local blink = require 'blink.cmp'

-- Mason Setup
mason.setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

-- Servers Configuration (merged over nvim-lspconfig's defaults via vim.lsp.config)
local servers = {
  clangd = {},
  ts_ls = {
    settings = { completions = { completeFunctionCalls = true } },
  },
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
}

-- Capabilities for LSP (blink.cmp + folding)
local capabilities = blink.get_lsp_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})
vim.lsp.config('*', { capabilities = capabilities })
for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    -- Formatting for TypeScript is handled by conform/prettier
    if client.name == 'ts_ls' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    on_attach(client, ev.buf)
  end,
})

-- Installs the servers and calls vim.lsp.enable() for each of them
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_enable = true,
}

-- Optional: Snippet Support
require 'colorizer'.setup {
  '*', -- Apply to all filetypes
}
require 'nvim-autopairs'.setup {
  enable_check_bracket_line = false,
  check_ts = true,
  ts_config = {
    lua = { 'string' },
    javascript = { 'template_string' },
    java = false,
  },
}
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}
-- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
-- local npairs = require 'nvim-autopairs'
-- npairs.setup {
--   enable_check_bracket_line = false,
--   check_ts = true,
--   ts_config = {
--     lua = { 'string' },
--     javascript = { 'template_string' },
--     java = false,
--   },
-- }
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
--
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   completion = {
--     completeopt = 'menu,menuone,noinsert',
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--   },
-- }
