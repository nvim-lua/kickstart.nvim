
-- Settings
vim.opt.relativenumber = true
-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
vim.opt.backspace = { 'indent', 'eol', 'start' }
--  By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
--  shown in any window) that has unsaved changes. This is to prevent you from
--  forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
--  hidden buffers helpful enough to disable this protection. See `:help hidden`
--  for more information on this.
vim.opt.hidden = true
--  This setting makes search case-insensitive when all characters in the string
--  being searched are lowercase. However, the search becomes case-sensitive if
--  it contains any capital letters. This makes searching more convenient.
vim.opt.ignorecase = true
vim.opt.smartcase = true
--  Enable searching as you type, rather than waiting till you press enter.
vim.opt.incsearch = true
--  Unbind some useless/annoying default key bindings.
-- 'Q' in normal mode enters Ex mode. You almost never want this.
vim.keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })
-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- Do smart autoindenting when starting a new line.
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
-- Always block cursor
vim.opt.guicursor = ''
-- Disable highlighted search matches
vim.opt.hlsearch = false
-- Disable swapfiles
vim.opt.swapfile = false
-- undo settings
vim.opt.undodir = vim.fn.expand('$HOME') .. '/nvim/undo'
vim.opt.undofile = true
-- Enables 24-bit RGB color
vim.opt.termguicolors = true
-- Scroll settings
vim.opt.scrolloff = 8
-- Turn off -- INSERT -- message
vim.opt.showmode = false
-- Add column for hints to prevent gitter
vim.opt.signcolumn = 'yes'
-- Highlight current line of cursor
vim.opt.cursorline = true
-- Clipboard settings
-- ALWAYS use the clipboard for ALL operations (instead of interacting with
--the '+' and/or '*' registers explicitly)
-- vim.opt.clipboard = 'unnamedplus'
-- Wrappring settings
vim.opt.wrap = false
--global status line
vim.opt.laststatus = 3


-- Colorscheme
-- https://github.com/projekt0n/github-nvim-theme
require("github-theme").setup({
  specs = {
    all = {
      diag = {
        error = 'red',
        hint = 'orange',
      },
    }
  },

  groups = {
    all = {
      StatusLine = {link = "Comment"},
      Search = {link = "TSNote"},
      TSField = {}
    }
  }
})
-- vim.cmd [[colorscheme github_dark_colorblind]]
vim.cmd.colorscheme('github_dark_colorblind')




-- Telescope config
-- mostly defaults pulled from the docs
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    sorting_strategy = "ascending",
    -- winblend = 30,
    layout_config = {
        horizontal = {
            prompt_position = "top",
            width = 0.95,
            height = 0.95
        }
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-y>"] = actions.select_default,
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}
-- require('telescope').load_extension('fzf')
-- require('telescope').load_extension('dap')

-- Emmet
-- C-y + ,
vim.g.user_emmet_mode = 'n'
vim.g.user_emmet_leader_key = ','
vim.g.user_emmet_settings = {
    typescript = {
        extends = 'jsx',
    },
    typescriptreact = {
        extends = 'jsx',
    }
}

vim.g.neoformat_try_node_exe = 1


-- -- Show diagnostic popup on cursor hover
-- vim.g.updatetime = 300
-- vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
--
-- Rust format on save
vim.g.rustfmt_autosave = 1
-- Filetype detection
vim.cmd('filetype plugin indent on')
