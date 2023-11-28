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
require('lazy').setup({
  {
    'nvim-treesitter',
    dependencies = {
      'nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'kylechui/nvim-surround',
    opts = { config = {} }
  },
  'Wansmer/treesj',
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'go', 'python', 'rust', 'javascript', 'typescript' },
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      scope_incremental = '<TAB>',
      node_decremental = '<BS>',
    }
  }
})

local lang_utils = require("treesj.langs.utils")
local options = {
  join = { space_in_brackets = false },
  split = { last_separator = true },
}

require("treesj").setup(
  {
    use_default_keymaps = false,
    langs = {
      python = {
        argument_list = lang_utils.set_preset_for_args(options),
        assignment = { target_nodes = { "list", "set", "tuple", "dictionary" } },
        call = { target_nodes = { "argument_list" } },
        dictionary = lang_utils.set_preset_for_dict(options),
        list = lang_utils.set_preset_for_list(options),
        parameters = lang_utils.set_preset_for_args(options),
        set = lang_utils.set_preset_for_list(options),
        tuple = lang_utils.set_preset_for_list(options),
      }
    }
  }
)

vim.keymap.set('n', '<leader>ct', '<cmd>:lua require("treesj").toggle()<cr>')
vim.keymap.set('n', '<leader>cs', '<cmd>:lua require("treesj").split()<cr>')
vim.keymap.set('n', '<leader>cj', '<cmd>:lua require("treesj").join()<cr>')
