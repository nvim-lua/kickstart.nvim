-- [[ Setting options ]]
vim.g.mapleader = ' '                  -- bindings for global
vim.g.maplocalleader = ','             -- bindings for local
vim.o.hlsearch = true
vim.o.colorcolumn = "80,120"           -- column width
vim.o.number = true
vim.o.relativenumber = true            -- relative numbers
vim.o.mouse = 'a'                      -- enable mouse
vim.o.clipboard = 'unnamedplus'        -- see :h clipboard
vim.o.breakindent = true
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'              -- signcolumn to the left of the numbers
vim.o.updatetime = 250                 -- Decrease update time
vim.o.completeopt = 'menuone,noselect' -- a better completion experience
vim.o.termguicolors = true             -- all the colors
vim.o.tabstop = 2                      -- Set whitespace to be 2 always
vim.o.shiftwidth = 2                   -- Set whitespace to be 2 always
vim.o.softtabstop = 2                  -- Set whitespace to be 2 always
vim.o.expandtab = true                 -- spaces are better than tabs

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
      }
    }
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

      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this
      -- { 'nvim-tree/nvim-web-devicons' }
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          }
        },
      }

      pcall(require('telescop').load_extension, 'fzf')
      pcall(require('telescop').load_extension, 'fzf')
    end
  },

  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  { import = 'custom.plugins' },
}, {})

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })                         -- silence the normal <Space>
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Move up half page" })                     -- center while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Move down half page" })                   -- center while scrolling
vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = "Next Buffer", silent = true })         -- easily change buffers
vim.keymap.set('n', '<C-k>', ':bprev<CR>', { desc = "Previous Buffer", silent = true })     -- easily change buffers
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = "Delete Buffer", silent = true }) -- close buffer
vim.cmd([[ nnoremap <silent> <expr> <CR> {-> v:hlsearch ? "<cmd>nohl\<CR>" : "\<CR>"}() ]]) -- clear the highlighted search with <CR>
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })       -- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })       -- Remap for dealing with word wrap

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telscope = require('telescope')
local telscopeb = require('telescope.builtin')

telscope.setup {
  defaults = {
    file_ignore_patterns = {
      "%.git",
      "node_modules",
      "%.idea",
      "project/target", --https://www.lua.org/pil/20.2.html
      "target",         --https://www.lua.org/pil/20.2.html
      "%.cache",
      "%.cpcache",
      "cljs%-runtime" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
-- Enable telescope fzf native, if installed
pcall(telscope.load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', telscopeb.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', telscopeb.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telscopeb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fF', function()
  telscopeb.find_files({
    no_ignore = true
  })
end, { desc = '[S]earch [F]iles (no ignore)' })

vim.keymap.set('n', '<leader>fG', telscopeb.git_files, { desc = '[F]ind [G]it' })
vim.keymap.set('n', '<leader>ff', telscopeb.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', telscopeb.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', telscopeb.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', telscopeb.live_grep, { desc = '[F]ind [g]rep' })
vim.keymap.set('n', '<leader>fd', telscopeb.diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fk', telscopeb.keymaps, { desc = '[F]ind [K]eymap' })
vim.keymap.set('n', '<leader>fc', telscopeb.colorscheme, { desc = '[F]ind [C]olorscheme' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c', 'cpp',
    'go', 'gomod', 'gosum', 'gowork',
    'lua',
    'vimdoc', 'vim',
    'clojure',
    'commonlisp',
    -- 'ocaml',
    'zig'
  },

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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- Create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>lr', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode Action')
  nmap('<leader>lf', vim.lsp.buf.format, '[F]ormat')
  nmap('<leader>lt', vim.lsp.buf.type_definition, '[T]ype Definition')
  nmap('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
  nmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
  nmap('<leader>la', vim.lsp.buf.add_workspace_folder, 'Workspace [A]dd Folder')
  nmap('<leader>lR', vim.lsp.buf.remove_workspace_folder, 'Workspace [R]emove Folder')
  nmap('<leader>ll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace [L]ist Folders')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<M-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
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
  clangd = {},
  gopls = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  clojure_lsp = {},
  -- ocamllsp = {},
  zls = {},
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
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local lspkind = require('lspkind')
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'conjure' },
    { name = 'buffer' }
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        buffer = "[Buffer]",
        conjure = "[Conjure]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]"
      })
    })
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
