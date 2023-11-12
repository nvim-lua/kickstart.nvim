-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
require('custom.lazy-bootstrap')

-- [[ Configure plugins ]]
require('custom.lazy-plugins')

-- [[ Basic Vim Options ]]
require("custom.options")

-- [[ Basic Keymaps ]]
require("custom.keymaps")

-- [[ Configure Telescope ]]
-- (fuzzy finder)
require('custom.telescope-setup')

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require('custom.treesitter-setup')

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require('custom.lsp-setup')

-- [[ Configure nvim-cmp ]]
-- (auto-completion)
require('custom.cmp-setup')



-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
