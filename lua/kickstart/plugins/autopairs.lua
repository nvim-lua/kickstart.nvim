-- 1. Load the plugin
vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }

-- 2. Initialize nvim-autopairs with Treesitter and FastWrap enabled
local npairs = require('nvim-autopairs')

npairs.setup({
    check_ts = true, -- Enable Treesitter integration
    fast_wrap = {
        -- Enabling this automatically maps <M-e> by default
        -- You do not need a separate vim.keymap line for it.
    },
})

-- 3. Setup completion integration (Safe-pcalled in case cmp hasn't loaded yet)
local status_cmp, cmp = pcall(require, 'cmp')
local status_handlers, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

if status_cmp and status_handlers then
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done() -- Automatically adds brackets after selecting a function/method[cite: 1]
    )
end


