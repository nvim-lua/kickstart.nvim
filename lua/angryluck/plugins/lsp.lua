return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = {} },

    -- Lua LSP for Neovim config
    { "folke/neodev.nvim", opts = {} },
  },

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- Lua helper function
        local nmap = function(keys, func, desc)
          vim.keymap.set(
            "n",
            keys,
            func,
            { buffer = event.buf, desc = "LSP: " .. desc }
          )
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        nmap(
          "gd",
          require("telescope.builtin").lsp_definitions,
          "[G]oto [D]efinition"
        )

        -- Find references for the word under your cursor.
        nmap(
          "gr",
          require("telescope.builtin").lsp_references,
          "[G]oto [R]eferences"
        )

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        nmap(
          "gI",
          require("telescope.builtin").lsp_implementations,
          "[G]oto [I]mplementation"
        )

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        nmap(
          "<leader>D",
          require("telescope.builtin").lsp_type_definitions,
          "Type [D]efinition"
        )

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        nmap(
          "<leader>ds",
          require("telescope.builtin").lsp_document_symbols,
          "[D]ocument [S]ymbols"
        )

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        nmap(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Highlight references of word under cursor
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentHighlightProvider then
        --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --
        --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        -- end
      end,
    })

    --  Broadcast cmp capabilities to servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    --  Available config keys:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    local servers = {
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      ltex = {
        filetypes = { "tex" },
        settings = {
          dictionary = {
            ["en-US"] = { "homotopy" },
          },
        },
      },
      hls = {
        filetypes = { "haskell", "lhaskell", "cabal" },
        haskell = {
          cabalFormattingProvider = "cabalfmt",
          formattingProvider = "fourmolu",
        },
        single_file_suppport = true,
      },
    }
    --  Use :Mason to install manually
    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { "stylua" })
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            capabilities,
            server.capabilities or {}
          )
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,

  -- To add "add to dictionary" to ltex, but doesn't work...
  -- { "vigoux/ltex-ls.nvim", dependencies = { "neovim/nvim-lspconfig" } },

  -- Something I tried, but didn't work:
  -- require("ltex-ls").setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   use_spellfile = false,
  --   filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
  --   settings = {
  --     ltex = {
  --       enabled = { "latex", "tex", "bib", "markdown" },
  --       language = "auto",
  --       diagnosticSeverity = "information",
  --       sentenceCacheSize = 2000,
  --       additionalRules = {
  --         enablePickyRules = true,
  --         motherTongue = "fr",
  --       },
  --       disabledRules = {
  --         fr = { "APOS_TYP", "FRENCH_WHITESPACE" },
  --       },
  --       dictionary = (function()
  --         -- For dictionary, search for files in the runtime to have
  --         -- and include them as externals the format for them is
  --         -- dict/{LANG}.txt
  --         --
  --         -- Also add dict/default.txt to all of them
  --         local files = {}
  --         for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
  --           local lang = vim.fn.fnamemodify(file, ":t:r")
  --           local fullpath = vim.fs.normalize(file, ":p")
  --           files[lang] = { ":" .. fullpath }
  --         end
  --
  --         if files.default then
  --           for lang, _ in pairs(files) do
  --             if lang ~= "default" then
  --               vim.list_extend(files[lang], files.default)
  --             end
  --           end
  --           files.default = nil
  --         end
  --         return files
  --       end)(),
  --     },
  --   },
  --  }
}
