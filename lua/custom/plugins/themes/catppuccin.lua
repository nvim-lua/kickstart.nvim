return {
            "catppuccin/nvim",
            name = "catppuccin",
            config = function()
                -- latte, frappe, macchiato, mocha
                vim.g.catppuccin_flavour = "frappe"
                require("catppuccin").setup()
            end
        }