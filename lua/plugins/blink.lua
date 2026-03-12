-- Autocompletion
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
  },
  init = function()
    -- set autocommand for blink-menu-sourcename.
    vim.api.nvim_create_autocmd('ColorScheme', {
      desc = 'set italic to BlinkCmpSource, and try to change fg',
      group = vim.api.nvim_create_augroup('ColorReadjust', { clear = true }),
      callback = function()
        local hl = {
          default = true,
          italic = true,
        }

        -- if the hl-group for the Menu-Selection has reverse property,
        -- then don't bother setting fg & bg, because it would be messed up anyway.
        if not vim.api.nvim_get_hl(0, { name = 'PmenuSel' }).reverse then
          hl.fg = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' }).fg
            or vim.api.nvim_get_hl(0, { name = 'BlinkCmpGhostText' }).fg
            or vim.api.nvim_get_hl(0, { name = 'NonText' }).fg
        end

        vim.api.nvim_set_hl(0, 'BlinkCmpSource', hl)
      end,
    })
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- preset = 'default',
      --
      -- I have my own keymaps now
      ['<C-space>'] = { 'show_documentation', 'hide_documentation' },
      ['<C-q>'] = { 'hide', 'fallback' },
      ['<C-l>'] = { 'select_and_accept', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-j>'] = { 'show', 'select_next', 'fallback_to_mappings' },

      ['<C-S-K>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-S-J>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-n>'] = { 'snippet_forward', 'fallback_to_mappings' },
      ['<C-p>'] = { 'snippet_backward', 'fallback_to_mappings' },

      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },

    term = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      kind_icons = Glyphs.kinds,
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 1500 },

      menu = {
        draw = {
          columns = {
            -- The following two components are from the default config
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            -- Add `source_name` to parse it and get lsp-provider name
            { 'source_name' },
          },
          components = {
            source_name = {
              width = { fill = true },
              text = function(ctx)
                -- either get the client_name aka lsp-provider "like lua_ls"
                -- or get the source name from blink's list of sources, see below.
                return ctx.item.client_name or ctx.source_name
              end,
              highlight = 'BlinkCmpSource',
            },
          },
        },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'blade-nav' },
      providers = {
        ['blade-nav'] = {
          module = 'blade-nav.blink',
          opts = {
            close_tag_on_complete = true, --default: true
          },
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
