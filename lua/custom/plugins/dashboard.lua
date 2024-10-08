local dash = {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      local logo = [[
                   @@@@@@           @@@@@@                   
                @@@@@@@@@@@       @@@@@@@@@@@                
            @@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@            
         @@@@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@@@         
       @@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@     
  @@@@@@  @@@@@@@@@@@@                 @@@@@@@@@@@@@@@@@@@@  
 @@@@@@@@@@@  @@@@                         @@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@                               @@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@                         @@@@  @@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@@                 @@@@@@@@@@@@  @@@@@@  
     @@@@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@       
         @@@@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@@@         
            @@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@            
                @@@@@@@@@@@       @@@@@@@@@@@                
                   @@@@@@           @@@@@@                   

         
 ██████╗ ██████╗ ███████╗ ██████╗
██╔════╝ ██╔══██╗██╔════╝██╔════╝
██║  ███╗██║  ██║███████╗██║     
██║   ██║██║  ██║╚════██║██║     
╚██████╔╝██████╔╝███████║╚██████╗
 ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝
                                 
    ]]

      logo = string.rep('\n', 1) .. logo .. '\n'

      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "Oil",                                                      desc = " Oil",             icon = "󰾅 ", key = "o" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      return opts
    end,
  },
}

return dash
