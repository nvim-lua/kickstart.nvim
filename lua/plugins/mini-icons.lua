return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.icons').setup({
      -- Enable all preset kinds
      preset = 'default',
      -- Customize icons for specific kinds
      devicons = {
        enabled = true,
        override = {
          -- File types
          default = '',
          lua = '',
          python = '',
          javascript = '',
          html = '',
          css = '',
          json = '',
          yaml = '',
          toml = '',
          markdown = '',
          -- Git
          git = '',
          github = '',
          gitlab = '',
          gitignore = '',
          -- Folders
          folder = '',
          folder_open = '',
          folder_empty = '',
          folder_empty_open = '',
          -- LSP
          error = '',
          warning = '',
          info = '',
          hint = '󰌵',
        },
      },
    })
  end,
}
