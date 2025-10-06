return {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = true,
    keys = {
		{ "<leader>cc", "<cmd>lua require('curl').open_curl_tab()<cr>", desc = "Open a curl tab scoped to the current working directory" },
		{ "<leader>csc", "<cmd>lua require('curl').create_scoped_collection()<cr>", desc = "Create or open a collection with a name from user input" },
		{ "<leader>cgc", "<cmd>lua require('curl').create_global_collection()<cr>", desc = "Create or open a global collection with a name from user input" },
    },
    on_attach = function (bufnr)
        -- These commands will prompt you for a name for your collection
        vim.keymap.set("n", "<leader>csc", function()
            curl.create_scoped_collection()
        end, { desc = "Create or open a collection with a name from user input" })

        vim.keymap.set("n", "<leader>cgc", function()
            curl.create_global_collection()
        end, { desc = "Create or open a global collection with a name from user input" })

        vim.keymap.set("n", "<leader>fsc", function()
            curl.pick_scoped_collection()
        end, { desc = "Choose a scoped collection and open it" })

        vim.keymap.set("n", "<leader>fgc", function()
            curl.pick_global_collection()
        end, { desc = "Choose a global collection and open it" })
    end 
}
