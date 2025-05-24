return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- Source for text in buffer
        "hrsh7th/cmp-path", -- Source for file system paths
        {
            "L3MON4D3/LuaSnip", -- Snippet Engine
            version = "v2.*",
            build = "make install_jsregexp", -- Allow lsp-snippet-transformations
        },
        "rafamadriz/friendly-snippets", -- Preconfigured snippets for different languages
        "onsails/lspkind.nvim", -- VS-Code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load() -- Required for friendly-snippets to work

        -- Settings for the appearance of the completion window
        vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "CmpSelect", { bg = "#000000", fg = "#b5010f" })
        vim.api.nvim_set_hl(0, "CmpBorder", { bg = "#000000", fg = "#b5010f" })

        cmp.setup({
           snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
            window = {
                 completion = {
                     border = "rounded",
                     winhighlight = "Normal:CmpNormal,CursorLine:CmpSelect,FloatBorder:CmpBorder",
                 }
            },
        })
        vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
        ]])
    end,
}
