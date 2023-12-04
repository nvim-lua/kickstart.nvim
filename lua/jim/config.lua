-- config.lua
-- Set <space> = leader key  ( set first;  See `:help mapleader` )
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.g.minisurround_disable=true

--------------------------
-- Install package manager, lazy.nvim
--------------------------
--    https://github.com/folke/lazy.nvim,  `:help lazy.nvim.txt` for more info
--
-- stdpath is vimscript; vim.fn says call vimscript from inside lua
-- :echo stdpath("data") to see
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- vim.fn is bridge to vimscript.   and `system`  is vimscript command
--
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
  --  'tpope/vim-fugitive',
  --   'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- add gruvbox, must setup 1st;  in options.lua set colorscheme.
  { 'ellisonleao/gruvbox.nvim' },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  --  mason -- installs the lsp server
  --  nvim-lspconfig -- connect LSP  to our setup ?
  {
    -- LSP Configuration & Plugins
    -- Need BOTH  nvim-lspconfig and mason?  (SEE Nat Bennett  blog post)
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      -- NOTE !!
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    }, -- end dependencies
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
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  --        hardtime.nvim (nvim advice?) 2023-09-03
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

  -------------------
  --  Comments.nvim
  -------------------
  -- 2023-11-12 Comment.nvim keymaps conflict with my Telescope keymaps
  --  { 'numToStr/Comment.nvim',   opts = {} },


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

-----------------
--      TELESCOPE
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-----------------
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

---------------------------------
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`{{{
---------------------------------
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


----------------------
-- [[ Configure LSP ]]
----------------------
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

-- cmp WAS here
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
