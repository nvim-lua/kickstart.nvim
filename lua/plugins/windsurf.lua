-- Windsurf for LazyVim - Fixed syntax errors
return {
    -- Windsurf plugin
    {
        "Exafunction/windsurf.nvim",
        event = "InsertEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        keys = {
            { "<leader>ct", "<cmd>Codeium Toggle<cr>", desc = "Toggle Codeium" },
        },
        config = function()
            require("codeium").setup({})
            
            -- Add codeium to nvim-cmp sources after everything loads
            vim.schedule(function()
                local cmp = require('cmp')
                local config = cmp.get_config()
                table.insert(config.sources, 1, { name = "codeium" })
                cmp.setup(config)
            end)
        end,
    },
}
