return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.starter').setup {
        header = table.concat({
          '███╗   ██╗██╗   ██╗██╗███╗   ███╗',
          '████╗  ██║██║   ██║██║████╗ ████║',
          '██╔██╗ ██║██║   ██║██║██╔████╔██║',
          '██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
          '██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
          '╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
          '',
          '                                 ',
        }, '\n'),
        items = {
          { action = 'Telescope find_files', name = ' 🔍  Find File', section = 'Files' },
          { action = 'Telescope oldfiles', name = ' 📂  Recent Files', section = 'Files' },
          { action = 'Telescope live_grep', name = ' 🔎  Find Text', section = 'Search' },
          { action = 'Lazy update', name = ' 🔄  Update Plugins', section = 'Plugins' },
          { action = 'qall', name = ' ↪️  Quit', section = 'Exit' },
        },
        footer = 'Neovim - The hyperextensible Vim-based text editor',
        content_hooks = {
          require('mini.starter').gen_hook.adding_bullet '*',
          require('mini.starter').gen_hook.aligning('center', 'center'),
        },
      }
    end,
  },
}
