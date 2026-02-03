return {
    -- Main Snacks Configuration with Core Features & Keymaps
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            -- Toggle between root and cwd
                            ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
                        },
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            -- Quick Access
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },

            -- Find (f prefix)
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = "[F]ind [C]onfig Files" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "[F]ind [F]iles" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "[F]ind [G]it Files" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "[F]ind [R]ecent Files" },

            -- Git (g prefix)
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git [D]iff" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git [S]tatus" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git [S]tash" },

            -- Search (s prefix) - Matching Telescope keymaps
            { "<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent Files" },
            { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[S]earch in Open Files" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch [B]uffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[S]earch Open [B]uffers" },
            { "<leader>sc", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
            { "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "[S]earch [M]arks" },
            { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = "[S]earch [N]eovim files" },
            { "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
            { "<leader>ss", function() Snacks.picker() end, desc = "[S]earch [S]elect Picker" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord", mode = { "n", "x" } },

            -- Notifications
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },

            -- Explorer
            { "<leader>fe", function() Snacks.explorer({ cwd = vim.fs.root(0, ".git") or vim.fn.getcwd() }) end, desc = "[F]ile [E]xplorer (root)" },
            { "<leader>fE", function() Snacks.explorer() end, desc = "[F]ile [E]xplorer (cwd)" },
            { "<leader>e", "<leader>fe", desc = "Explorer (root)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer (cwd)", remap = true },

            -- UI
            { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        },
    },
}
