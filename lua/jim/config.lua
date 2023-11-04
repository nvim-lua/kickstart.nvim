print(' this is ./lua/init.lua') --

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.g.minisurround_disable=true

-- for now turn on LIGHT
vim.cmd 'set background=light'

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- vim.fn is bridge to vimscript.   and `system`  is vimscript command
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
--  vim.opt is like using :set;    :append or :prepend is like vimscript set+=
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Nvim-R
  'jalvesaq/Nvim-R',
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  --  mason -- installs the lsp server
  --  nvim-lspconfig -- connect LSP  to our setup ?
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE !!
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion;   exist several  `extensions` to nvim-cmp
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',    opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        -- jr: next line overrides Nvim-R g next chunk;  how to change?
        -- vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },


  -- add gruvbox
  { 'ellisonleao/gruvbox.nvim' },

  -- Configure LazyVim to load gruvbox
  --
  --
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'gruvbox',
    },
  },

  --        hardtime.nvim (nvim advice?) 2023-09-03
  --
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  --        lush, tool to edit colorschemes, using lua, EXCELLENT tutorials..
  --        (but why need?)

  {  -- {{{
    'rktjmp/lush.nvim',
  }, -- }}}


  -- Statusline:   See `:help lualine.txt` (opts is same as require('xxxx').setup())
  --{{{
  --
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  }, --
  -- }}}
  --
  --  bufferline  (purpose:  pretty up top of TABS/Buffers - first LEARN TABS vs Windows vs TMUX)
  { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },

  -- Add indentation guides even on blank lines
  -- 2023-10-26  gives startup errors, but seems to work
  -- ???
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      -- :IBLToggle
      -- See `:help indent-blankline.txt`
      --:help ibl.config.indent.char
      -- 2023-10-27  jr:  had remove char, show_trail...   <otherwise errors>
      --char = '┊',     use default
      -- show_trailing_blankline_indent = false,
    } -- end opts
  },
  -- this fixes an issue when jumping from neovim to tmux
  -- but also means can not easily change pane size, width, height
  -- 2023-10-26
  -- 2023-10-31 dont' quite undertand behavior, hold off
  {
    "christoomey/vim-tmux-navigator",
    event = "BufReadPre",
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',   opts = {} },

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
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --    jr:  2023-08-25
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- jr:  HOST
-- $HOST is shell environmental var, set by initialize.zsh
local HOST = os.getenv 'HOST' --- which machine?
if true then
  print('LUA thinks I am using ' .. vim.inspect(HOST))
end

if HOST == 'jim-ThinkPad-T480' then
  vim.cmd [[ set background=light]]
else
  vim.cmd [[ set background=dark]] -- acer-desktop
end

-- [[ Nvim-R ]]
vim.cmd([[ let R_args= ['--no-save', '--quiet'] ]]) -- minimize startup
vim.cmd([[ let R_assign=2 ]])                       -- underline becomes left arrow
vim.cmd([[ let R_enable_comment=1 ]])               -- toggle comments with xx
vim.cmd([[let g:LanguageClient_serverCommands = {
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ }
]])

--[[
2023-10-07 another try with R & LSP
1) Mason to install r language server (takes a while)
2) Add code below, let g:LanguageClient ... this is <https://github.com/autozimu/LanguageClient-neovim>
3) no errors, Lsp works for *.R !

BUT, can not get r language server to fire up with *.qmd
Add to bottom of *.qmd, *.R file:
#		/* vim: set filetype=r : */

  --nope   \ 'qmd': ['R', '--slave', '-e', 'languageserver::run()'],
-- compare to lua version: https://github.com/neovim/nvim-lspconfig/blob/1028360e0f2f724d93e876df3d22f63c1acd6ff9/lua/lspconfig/server_configurations/r_language_server.lua#L8
--]]
--

-- always display top/bottom 8 lines
vim.opt.scrolloff     = 8
vim.opt.colorcolumn   = "80"

-- Set highlight on search
vim.o.hlsearch        = false

-- Make line numbers default
vim.wo.number         = true
vim.wo.relativenumber = true
vim.wo.foldmethod     = "manual" -- cleaner vs "marker"
vim.wo.foldcolumn     = '1'      -- can be '0-9' (string)

-- Enable mouse mode
vim.o.mouse           = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard       = 'unnamedplus'

-- Enable break indent
vim.o.breakindent     = true

-- Hitting <TAB>  (experimnetal)
vim.o.ts              = 2 -- 1 <TAB> is 2 characters
vim.o.sw              = 0 -- don't know
-- tw = maximum width of text (or 0 to disable)

-- <TAB>  becomes all spaces, no <TAB> ch
vim.o.expandtab       = true

-- don't break within a word
vim.o.linebreak       = false

-- Save undo history
vim.o.undofile        = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase      = true
vim.o.smartcase       = true

-- Keep signcolumn on by default
vim.wo.signcolumn     = 'yes'

-- Decrease update time
vim.o.updatetime      = 250
vim.o.timeoutlen      = 300 -- time mapping waits for next char
vim.o.ttimeoutlen     = 10  -- time <ESC> delays before registers

-- Set completeopt to have a better completion experience
vim.o.completeopt     = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this (yes: 2023-09-03)
vim.o.termguicolors   = true

----------------------
-- [[ Basic Keymaps ]]
----------------------
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'q', '<Nop>', { silent = true })

-- REF: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
-- if dd action holds content:  keep it
-- if dd action holds BLANK LINE:  sent to black hole _dd
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then return '"_dd' end
  return "dd"
end, { expr = true })

-- vim.keymap.set( {'n', '<leader>]nc',
-- Remap for dealing with word wrap
-- jr 2023-10-07 Not cause of sticky line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move Up, center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move Down, center' })

--  vim.keymap.set('n', '<leader>ck', ':e ~/.config/kickstart/init.lua<CR>', { desc = 'Config Kickstart' })
vim.keymap.set('n', '<leader>tn', ':e ~/code/docs/tech_notes/300_tech_notes.qmd<CR>', { desc = 'Tech Notes' })
vim.keymap.set('n', '<leader>mln', ':e ~/code/docs/tech_notes/500_ML_Notes.qmd<CR>', { desc = 'ML Notes' })
vim.keymap.set('n', '<leader>bw', 'i**<esc>Ea**<esc>w', { desc = "[B]old [W]ord" })
--  insert # --------...
vim.keymap.set("n", "<leader>ic", "yypVr-I# <ESC>", { desc = "[ic]insert comment line" })

--              [[ Highlight on yank ]]
--              See `:help vim.highlight.on_yank()`
--{{{
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
}) -- }}}

-- easier, clearer,  skeleton file
vim.cmd([[
autocmd BufNewFile *.qmd r ~/.config/kickstart/skeleton/skeleton.qmd
]])
------------------------------------------------------
--             which-key
------------------------------------------------------
--             experiment; add my keymaps to which-key
--             stolen:  REF: https://github.com/hackorum/nfs/blob/master/lua/whichkey-config/init.lua
------------------------------------------------------
--{{{
local wk = require 'which-key'
wk.setup {
  plugins = {
    marks = false,
    registers = true,
    spelling = { enabled = false, suggestions = 20 },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      --      z = false,
      g = false,
    },
  },
}
local mappings = {
  -- g is an experiment and duplicates done elsewhere
  g = {
    name = "temp file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    g = { "<cmd>Telescope live_grep<cr>", "Full Text Search" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    q = { "<cmd>q<cr>", 'Quit - no warn' },
  },
  t = {
    name = "telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },                                          -- create a binding with label
    z = { "<cmd>Telescope find_files<cr>", "Find File", desc = "Search Home", pwd = '/home/jim' }, -- create a binding with label
  },

  q = { ':q<cr>', 'Quit - no warn' },
  Q = { ':wq<cr>', 'Save & Quit' },
  w = { ':w<cr>', 'Save' },
  x = { ':bdelete<cr>', 'Close' },
  -- use :RKill to stop R, close terminal (not guaranteed)
  z1 = { '<C-W>p', 'other window' },
  z2 = { '<C-W>pAjunk<esc>', 'other window junk' },
  rk = { ':RKill<CR>', 'RKill , but not guaranteed to close terminal' },
  -- use <leader>ck  E = { ':e ~/.config/kickstart/init.lua<cr>', 'Edit KICKSTART config' },
  ck = { ':e ~/.config/kickstart/init.lua<cr>', '[ck] Edit KICKSTART config' },
  --  f = { ":Telescope find_files<cr>", "Telescope Find Files" },
  --   r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
}
local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
-- }}}
--
------------------------------------------------------
--             require("lspconfig").sumneko_lua.setup({
------------------------------------------------------
--             tell lua ls that `vim` is global var
--
require('lspconfig').lua_ls.setup { -- {{{
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
} -- }}}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
--vim.keymap.set('n', '<leader>sfh',require("telescope.builtin").find_files(cwd='/home/jim'))    -- ERRORS
-- :lua require("telescope.builtin").find_files({ cwd = tostring(os.getenv("HOME")), prompt_title="hello"})  -- Works at cLI
-- :lua  require("telescope.builtin").find_files(cwd={'/home/jim'})    -- how to set cwd
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
--
-- See `:help nvim-treesitter`{{{
--
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  -- 2023-10-07 appears to be upstream (nvim-treesitter problem;  I don't know what to do)
  -- SEE:  https://github.com/nvim-lua/kickstart.nvim/issues/441
  require('nvim-treesitter.configs').setup {

    -- Add languages to be installed here that you want installed for treesitter
    --
    ensure_installed = { 'lua', 'python', 'javascript', 'vimdoc', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>', -- problem here
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
--   end treesitter
-- }}}
--
--
-- experimnetal - works!  (2023-09-02)
-- ... but only small change in status line
----------------
-- PURPOSE:   override default colo for color group StatusLineNC
-- 2 windows? change status line for non-current(NC)
vim.cmd [[
  highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkgray
  ]]

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },


  -- lua_ls is new name for sumneko_lua
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,

      -- fix for lua_ls 'vim' & global
      -- this line replaced:
      --      settings = servers[server_name],
      -- but does it break other lsp servers??
      --
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

--
--   LUASNIP
local luasnip = require 'luasnip'
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local f = ls.function_node
-- HELPER
local filename = function()
  return { vim.fn.expand '%:p' }
end

-- SNIPS
ls.add_snippets('all', { -- `all` all filetypes, `lua` only lua ft
  s('luaxx', { t 'this is lua file!' }),
  s('sep', t { '---------------' }),

  -- snip: add file's filename
  s({
    trig = "filename",
    namr = "Filename",
    dscr = "insert file name",
  }, {
    f(filename, {}),
  }),
})
---------------
-- next line:  allows use of snippet collection in vscode (??)
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- nvim-cmp configuration
-- [[ Configure hrsh7th nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- TAB selects NEXT item (CR to complete)
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = { -- need nvim-cmp extensions?
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer',  keyword_length = 5 },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
