return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Footer dinâmico
      local function footer()
        local stats = require('lazy').stats()
        local plugins = stats.count
        local ms = (math.floor(stats.startuptime * 100) / 100)
        return '⚡ Neovim carregado com ' .. plugins .. ' plugins em ' .. ms .. 'ms'
      end

      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            '',
            ' ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░      ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░▒▓███████▓▒░  ',
            '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░     ░▒▓█▓▒▒▓███▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ',
            '                                                                                                  ',
            '                                                                                                  ',
          },

          center = {
            { icon = ' ', desc = 'New File             ', action = 'ene | startinsert', key = 'n' },
            { icon = '󰈞 ', desc = 'Find File            ', action = 'Telescope find_files', key = 'f' },
            { icon = '󰈬 ', desc = 'Find Word            ', action = 'Telescope live_grep', key = 'w' },
            { icon = ' ', desc = 'Recent Files         ', action = 'Telescope oldfiles', key = 'r' },
            { icon = ' ', desc = 'Projects             ', action = 'Telescope projects', key = 'p' },
            { icon = ' ', desc = 'Neovim Config        ', action = 'edit ~/.config/nvim/init.lua', key = 'c' },
            { icon = ' ', desc = 'Update Plugins       ', action = 'Lazy update', key = 'u' },
            { icon = ' ', desc = 'Quit                 ', action = 'qa', key = 'q' },
          },
          footer = { footer() },
        },
      }
    end,
  },
}
