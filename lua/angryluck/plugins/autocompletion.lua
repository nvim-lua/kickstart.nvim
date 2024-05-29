return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      -- build needed for regex support
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- {
        --    -- premade snippets
        --   "rafamadriz/friendly-snippets",
        --   config = function()
        --     require("luasnip.loaders.from_vscode").lazy_load { exclude = { "tex" } }
        --     require("luasnip.loaders.from_snipmate").lazy_load { exclude = { "tex" } }
        --   end,
        -- },
      },
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    "saadparwaiz1/cmp_luasnip",

    -- Adds LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({ enable_autosnippets = true })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- old one: completeopt = "menuone,noselect",
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-8),
        ["<C-f>"] = cmp.mapping.scroll_docs(8),
        -- Accept ([y]es) the completion
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        -- Manually trigger a completion from nvim-cmp (normally not needed)
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "neorg" },
        { name = "orgmode" },
      },
    })
  end,
}
