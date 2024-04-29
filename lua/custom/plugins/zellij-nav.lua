return {
    "https://git.sr.ht/~swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
        {
            "<c-h>", "<cmd>ZellijNavigateLeft<cr>",
            {silent = true, desc = "navigate left"}
        }, {
            "<c-j>", "<cmd>ZellijNavigateDown<cr>",
            {silent = true, desc = "navigate down"}
        },
        {
            "<c-k>", "<cmd>ZellijNavigateUp<cr>",
            {silent = true, desc = "navigate up"}
        }, {
            "<c-l>", "<cmd>ZellijNavigateRight<cr>",
            {silent = true, desc = "navigate right"}
        }
    },
    opts = {}
}
