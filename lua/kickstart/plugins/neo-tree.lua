-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
    filtered_items = {
      visible = true, -- show filtered items if you want them dimmed
      hide_dotfiles = false, -- show .env, .github, etc.
      hide_gitignored = true, -- hide files from .gitignore
      hide_hidden = false, -- don't hide hidden files
      hide_by_name = {
        '.git', -- usually keep .git hidden
      },
      never_show = {},
    },
  },
}
