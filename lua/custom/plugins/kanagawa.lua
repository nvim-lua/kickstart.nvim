return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup {
      statementStyle = { italic = false },
      functionStyle = { italic = false },
      typeStyle = { italic = false },
      colors = {
        palette = {
          -- change all usages of these colors
          sumiInk0 = '#0D0D0D',
          fujiWhite = '#FFFFFF',
        },
        keywordStyle = { italic = false },
        commentStyle = { italic = false },
        theme = {
          -- change specific usages for a certain theme, or for all of them
          wave = {
            ui = {
              float = {
                bg = 'none',
              },
            },
          },
          dragon = {
            syn = {
              parameter = 'yellow',
            },
          },
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    }
  end,
}
