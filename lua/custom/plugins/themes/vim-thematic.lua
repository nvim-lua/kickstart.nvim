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
\ 'aylin'  : {
\                },
\ 'ayu'  : {
\                },
\ 'blue-moon'  : {
\                },
\ 'bluloco'  : {
\                },
\ 'catppuccin'  : {
\                },
\ 'challenger_deep'  : {
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
\ 'gotham'  : {
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
\ 'pink-moon'  : {
\                },
\ 'pinkmare'  : {
\                },
\ 'purify'  : {
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
\ 'vim-monokai-tasty'  : {
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

    -- Retrieve all mappings
    local mappings = vim.api.nvim_get_keymap ''

    -- Iterate through the mappings to find and remove any existing ones for the commands
    for _, mapping in ipairs(mappings) do
      if mapping.cmd == 'ThematicRandom' or mapping.cmd == 'ThematicCatppuccino' then
        -- Remove existing mappings
        vim.api.nvim_del_keymap(mapping.mode, mapping.lhs)
      end
    end

    -- Set new mapping for ThematicRandom
    vim.api.nvim_set_keymap('n', '<leader>tr', ':ThematicRandom<CR>', { silent = true })

    -- Set new mapping for ThematicCatppuccino
    vim.api.nvim_set_keymap('n', '<leader>tc', ':Thematic catppuccin<CR>', { silent = true })
  end,
}
