return {
  'preservim/vim-thematic',
  config = function()
    vim.cmd [[
let g:thematic#themes = {
\ 'afterglow'  : {
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                },
\ 'anthraxylon'  : {
\                },
\ 'aquarium'  : {
\                },
\ 'ayu'  : {
\                },
\ 'blue-moon'  : {
\                },
\ 'bluloco'  : {
\                },
\ 'catppuccin'  : {
\                },
\ 'deus'  : {
\                },
\ 'dracula'  : {
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                },
\ 'embark'  : {
\                },
\ 'eva01'  : {
\                },
\ 'everblush'  : {
\                },
\ 'falcon'  : {
\                },
\ 'gloombuddy'  : {
\                },
\ 'hybrid'  : {
\                },
\ 'juliana'  : {
\                },
\ 'kanagawa'  : {
\                },
\ 'leuven'  : {
\                },
\ 'lucius'  : {
\                },
\ 'malifluous'  : {
\                },
\ 'materiam'  : {
\                },
\ 'melange'  : {
\                },
\ 'modus-operandi'  : {
\                  'background': 'light',
\                },
\ 'modus-vivendi'  : {
\                },
\ 'monochrome'  : {
\                },
\ 'moonfly'  : {
\                },
\ 'neon'  : {
\                },
\ 'nightfox'  : {
\                },
\ 'nightfly'  : {
\                },
\ 'night-owl'  : {
\                },
\ 'noirbuddy'  : {
\                },
\ 'nordic'  : {
\                },
\ 'nvimgelion'  : {
\                },
\ 'oceanic-next'  : {
\                },
\ 'off'  : {
\                  'typeface': 'Cascadia Code Regular',
\                },
\ 'oh-lucy'  : {
\                },
\ 'oxocarbon'  : {
\                },
\ 'palenight'  : {
\                },
\ 'palenightfall'  : {
\                },
\ 'papaya'  : {
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                },
\ 'plain'  : {
\                },
\ 'pencil_dark' :{ 'colorscheme': 'pencil',
\                  'background': 'dark',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Dank Mono Italic',
\                  'font-size': 11,
\                  'transparency': 10,
\                  'linespace': 8,
\                },
\ 'pencil_lite' :{ 'colorscheme': 'pencil',
\                  'background': 'light',
\                  'laststatus': 0,
\                  'ruler': 1,
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                  'fullscreen': 1,
\                  'transparency': 0,
\                  'font-size': 11,
\                  'linespace': 6,
\                },
\ 'pinkmare'  : {
\                },
\ 'rasmus'  : {
\                },
\ 'rose-pine'  : {
\                },
\ 'sacredforest'  : {
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                },
\ 'solarized'  : {
\                  'typeface': 'Victor Mono Regular Nerd Font Complete Mono',
\                },
\ 'solarized8'  : {
\                  'typeface': 'FuraCode Nerd Font Mono Light',
\                },
\ 'tender'  : {
\                },
\ 'tokyonight'  : {
\                },
\ 'tokyonight-night'  : {
\                },
\ 'tokyonight-storm'  : {
\                },
\ 'tokyonight-day'  : {
\                },
\ 'tokyonight-moon'  : {
\                },
\ 'zephyr'  : {
\                },
\ }



let g:thematic#defaults = {
\ 'background': 'dark',
\ 'laststatus': 2,
\ 'typeface': 'Dank Mono',
\ 'font-size': 11,
\ 'transparency': 10,
\ 'linespace': 2,
\ }

let g:thematic#theme_name = 'catppuccin'
]]
  end,
}
