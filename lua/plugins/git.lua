-- [plugins/git.lua]
return {
    { -- Adds git related signs + keymaps
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre", -- load only when a file is opened
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = true, -- shows git blame at end of line
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
                delay = 500,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

            -- Keymaps on attach
            on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map("n", "]c", gs.next_hunk, "Next Hunk")
            map("n", "[c", gs.prev_hunk, "Prev Hunk")

            -- Actions
            map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage Hunk")
            map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset Hunk")
            map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>hb", function() gs.blame_line { full = true } end, "Blame Line")
            map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Blame Line")
            map("n", "<leader>hd", gs.diffthis, "Diff This")
            map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
            map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
            end,
        },
    },

    { -- Git wrapper
        "tpope/vim-fugitive",
        cmd = { "Git", "G" }, -- lazy load only on :Git commands
    },

--     { -- Lazygit UI (optional)
--         "kdheepak/lazygit.nvim",
--         cmd = "LazyGit",
--         dependencies = { "nvim-lua/plenary.nvim" },
--         keys = {
--             { "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
--         },
--     },
}
