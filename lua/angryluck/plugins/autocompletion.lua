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
        require("luasnip.loaders.from_lua").lazy_load({
          -- If you set path manually, luasnip has to scan less
          -- paths = "~/.config/nvim/snippets/",
        })
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

    vim.keymap.set(
      "n",
      "<Leader>L",
      "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/luasnippets/'})<CR>"
    )
    luasnip.config.setup({
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      update_events = "TextChanged,TextChangedI",
    })

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
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-8),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(8),
        -- Accept ([y]es) the completion
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end),
        -- Manually trigger a completion from nvim-cmp (normally not needed)
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "n", "i", "s" }),
        ["<C-k>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "n", "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
        -- Better completions, especially for latex
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
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
