return {
    {
        "Olical/conjure",
        ft = { "clojure", "fennel", "janet", "racket", "hy", "scheme", "common lisp", "julia", "rust", "lua", "python" },
        lazy = true,
        init = function()
            vim.g['conjure#extract#tree_sitter#enabled'] = true
        end,
        dependencies = {
            "PaterJason/cmp-conjure",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "PaterJason/cmp-conjure",
        lazy = true,
        dependencies = { "nvim-cmp" },
        config = function()
            local cmp = require("cmp")
            local cfg = cmp.get_config()
            table.insert(cfg.sources, { name = "conjure" })
            return cmp.setup(cfg)
        end,
    }
}
