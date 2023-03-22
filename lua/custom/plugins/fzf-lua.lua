return {
            "ibhagwan/fzf-lua",
            -- optional for icon support
            dependencies = { "kyazdani42/nvim-web-devicons" },
            config = function()
                vim.api.nvim_set_keymap("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })

        vim.api.nvim_set_keymap(
        "n",
        "<c-F>",
        "<cmd>lua require('fzf-lua').grep_project()<CR>",
        { noremap = true, silent = true }
        )
            end
        }