return {
  'goolord/alpha-nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local ascii_arts = {
      kraken = {
        "                                   ",
        "                                   ",
        "                                   ",
        "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
        "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
        "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
        "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
        "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
        "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
        "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
        " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
        " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
        "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
        "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
      },
      skull = {
        '                     .:::!~!!!!!:.',
        '                  .xUHWH!! !!?M88WHX:.',
        '                .X*#M@$!!  !X!M$$$$$$WWx:.',
        '               :!!!!!!?H! :!$!$$$$$$$$$$8X:',
        '              !!~  ~:~!! :~!$!#$$$$$$$$$$8X:',
        '             :!~::!H!<   ~.U$X!?R$$$$$$$$MM!',
        '             ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!',
        '               !:~~~ .:!M"T#$$$$WX??#MRRMMM!',
        '               ~?WuxiW*`   `"#$$$$8!!!!??!!!',
        '             :X- M$$$$       `"T#$T~!8$WUXU~',
        '            :%`  ~#$$$m:        ~!~ ?$$$$$$',
        '          :!`.-   ~T$$$$8xx.  .xWW- ~""##*"',
        '.....   -~~:<` !    ~?T#$$@@W@*?$$      /`',
        'W$@@M!!! .!~~ !!     .:XUW$W!~ `"~:    :',
        '#"~~`.:x%`!!  !H:   !WM$$$$Ti.: .!WUn+!`',
        ':::~:!!`:X~ .: ?H.!u "$$$B$$$!W:U!T$$M~',
        '.~~   :X@!.-~   ?@WTWo("*$$$W$TH$! `',
        'Wi.~!X$?!-~   :: ?$$$B$Wu("**$RM!',
        '$R@i.~~ !    ::   ~$$$$$B$$en:``',
        '?MXT@Wx.~   ::     ~"##*$$$$M'
      }
    }

    dashboard.section.header.val = require("ascii").art.misc.krakens.sleekraken

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
      dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
    }

    -- Set footer
    local handle = assert(io.popen('fortune -s'))
    local fortune = handle:read("*all")
    handle:close()
    dashboard.section.footer.val = fortune
    dashboard.section.header.opts.hl = "Title"
    dashboard.section.buttons.opts.hl = "Debug"
    dashboard.section.footer.opts.hl = "Conceal"
    dashboard.config.opts.noautocmd = true

    -- vim.cmd[[autocmd User AlphaReady echo 'ready']]

    alpha.setup(dashboard.opts)
  end
}
