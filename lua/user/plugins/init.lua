-- [[ Plugins ]]
-- Managed by Neovim's built-in plugin manager, see `:help vim.pack`.
-- Plugins are installed into stdpath('data')/site/pack/core/opt and their
-- versions are pinned in nvim-pack-lock.json (tracked in git).
--
--   :PackUpdate   download updates and review them (:write to apply, :quit to cancel)
--   :PackList     show installed plugins (offline, nothing is changed)
--   :PackClean    delete plugins that are no longer listed below

local gh = function(repo)
  return 'https://github.com/' .. repo
end

-- Build steps, run after a plugin is installed or updated.
-- Must be registered before vim.pack.add() so they also run on first install.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('user-pack-build', { clear = true }),
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    local function run(cmd)
      local res = vim.system(cmd, { cwd = path }):wait()
      if res.code ~= 0 then
        vim.notify(('Build of %s failed (%s):\n%s'):format(name, table.concat(cmd, ' '), res.stderr), vim.log.levels.ERROR)
      end
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run { 'make' }
    elseif name == 'LuaSnip' and vim.fn.executable 'make' == 1 then
      run { 'make', 'install_jsregexp' } -- regex support in snippet transformations
    elseif name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      require('nvim-treesitter').update():wait(300000) -- parsers must match the plugin version
    end
  end,
})

vim.pack.add({
  -- Shared libraries
  gh 'nvim-lua/plenary.nvim', -- Lua utilities (telescope, todo-comments, lazygit)
  gh 'nvim-tree/nvim-web-devicons', -- file icons (telescope, bufferline, lualine)
  gh 'nvim-mini/mini.icons', -- file icons (oil, render-markdown)

  -- Colorschemes
  gh 'folke/tokyonight.nvim',
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
  gh 'projekt0n/github-nvim-theme',
  gh 'cocopon/iceberg.vim',

  -- UI
  gh 'folke/which-key.nvim', -- shows pending keybinds
  gh 'nvim-lualine/lualine.nvim', -- status line
  { src = gh 'akinsho/bufferline.nvim', version = vim.version.range '4' }, -- buffer tabs
  gh 'lukas-reineke/indent-blankline.nvim', -- indentation guides
  gh 'dstein64/nvim-scrollview', -- scrollbar
  gh 'folke/todo-comments.nvim', -- highlight TODO/FIXME comments
  gh 'j-hui/fidget.nvim', -- LSP progress messages

  -- Editing and navigation
  gh 'stevearc/oil.nvim', -- file manager as a buffer
  gh 'folke/flash.nvim', -- jump anywhere with a few keystrokes
  gh 'karb94/neoscroll.nvim', -- smooth scrolling
  gh 'szw/vim-maximizer', -- maximize a split
  gh 'folke/persistence.nvim', -- sessions
  gh 'RRethy/nvim-align', -- align text
  gh 'christoomey/vim-tmux-navigator', -- move between splits and tmux panes
  gh 'dstein64/vim-startuptime', -- :StartupTime profiling

  -- Telescope
  { src = gh 'nvim-telescope/telescope.nvim', version = vim.version.range '*' }, -- latest release
  gh 'nvim-telescope/telescope-fzf-native.nvim', -- faster sorting (built with make)
  gh 'nvim-telescope/telescope-ui-select.nvim', -- telescope for vim.ui.select

  -- Treesitter
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },

  -- LSP, completion, formatting, linting
  gh 'neovim/nvim-lspconfig', -- base configs for language servers
  gh 'folke/lazydev.nvim', -- Neovim Lua API for lua_ls
  gh 'hrsh7th/nvim-cmp', -- completion engine
  gh 'hrsh7th/cmp-nvim-lsp',
  gh 'hrsh7th/cmp-buffer',
  gh 'hrsh7th/cmp-path',
  gh 'L3MON4D3/LuaSnip', -- snippet engine
  gh 'saadparwaiz1/cmp_luasnip',
  gh 'rafamadriz/friendly-snippets', -- snippet collection
  gh 'stevearc/conform.nvim', -- formatting
  gh 'mfussenegger/nvim-lint', -- linting

  -- Git
  gh 'lewis6991/gitsigns.nvim', -- signs, hunks, blame
  gh 'sindrets/diffview.nvim', -- diff and file history views
  gh 'kdheepak/lazygit.nvim', -- lazygit in a floating window

  -- Markdown
  gh 'MeanderingProgrammer/render-markdown.nvim', -- render Markdown in the editor
}, { confirm = false })

-- Plugin setup (order matters: colorscheme first, then UI that reads its highlights)
require 'user.plugins.colorscheme'
require 'user.plugins.ui'
require 'user.plugins.editor'
require 'user.plugins.telescope'
require 'user.plugins.treesitter'
require 'user.plugins.completion'
require 'user.plugins.lua-ls'
require 'user.plugins.lsp'
require 'user.plugins.formatter'
require 'user.plugins.lint'
require 'user.plugins.git'
require 'user.plugins.markdown'

-- Plugin management commands and keymaps
vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update plugins (review, then :write to apply)' })

vim.api.nvim_create_user_command('PackList', function()
  vim.pack.update(nil, { offline = true })
end, { desc = 'List installed plugins' })

vim.api.nvim_create_user_command('PackClean', function()
  local unused = vim
    .iter(vim.pack.get())
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()
  if #unused == 0 then
    vim.notify 'No unused plugins'
    return
  end
  if vim.fn.confirm('Delete unused plugins?\n' .. table.concat(unused, '\n'), '&Yes\n&No', 2) == 1 then
    vim.pack.del(unused)
  end
end, { desc = 'Delete plugins that are no longer in the config' })

vim.keymap.set('n', '<leader>pu', '<cmd>PackUpdate<cr>', { desc = 'Update plugins' })
vim.keymap.set('n', '<leader>pl', '<cmd>PackList<cr>', { desc = 'List plugins' })
vim.keymap.set('n', '<leader>pc', '<cmd>PackClean<cr>', { desc = 'Clean unused plugins' })
