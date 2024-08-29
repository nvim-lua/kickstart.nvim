return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- some default parameters
      vim.lsp.inlay_hint.enable(true, nil)

      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      local on_attach = function(_, buffr)
        local kset = function(key, func, buffer, desc)
          vim.keymap.set('n', key, func, { buffer = buffer, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        kset('gd', require('telescope.builtin').lsp_definitions, buffr, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        kset('gr', require('telescope.builtin').lsp_references, buffr, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        kset('gI', require('telescope.builtin').lsp_implementations, buffr, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        kset('<leader>D', require('telescope.builtin').lsp_type_definitions, buffr, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        kset('<leader>ds', require('telescope.builtin').lsp_document_symbols, buffr, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        kset('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, buffr, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        kset('<leader>rn', vim.lsp.buf.rename, buffr, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        kset('<leader>ca', vim.lsp.buf.code_action, buffr, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        kset('K', vim.lsp.buf.hover, buffr, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        kset('gD', vim.lsp.buf.declaration, buffr, '[G]oto [D]eclaration')
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          local function dump_table(tbl)
            local result = ''
            for k, v in pairs(tbl) do
              result = result .. (k .. ': ' .. tostring(v)) .. ',\t'
            end
            return string.sub(result, 1, -2)
          end

          vim.lsp.inlay_hint.enable(true)
          if client and client.server_capabilities.inlayHintProvider then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      -- require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      --   require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      -- INFO: Using my own utils function instead of mason-lspconfig as it checks if the stuff is already installed
      -- outside of mason. This is useful for NixOS setup where mason version just doesn't work sometimes due to libc issues.

      -- We take the languages configured for a given profile
      -- Given the profile we take the LSPs configured for the languages
      -- Then we guarantee use or install the LSPs
      local languages = require('utils.profile').Languages()
      local languageServers = require 'utils.languages'
      local tmpTable = {}
      for _, lang in ipairs(languages) do
        for lsp, config in pairs(languageServers[lang]) do
          tmpTable[lsp] = config
        end
      end
      require('utils.mason').install(tmpTable, true)
      local lsp = require 'lspconfig'
      for server, config in pairs(tmpTable) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        config.on_attach = on_attach
        lsp[server].setup(config)
      end

      -- require('mason-lspconfig').setup {
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       -- This handles overriding only values explicitly passed
      --       -- by the server configuration above. Useful when disabling
      --       -- certain features of an LSP (for example, turning off formatting for tsserver)
      --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --       require('lspconfig')[server_name].setup(server)
      --     end,
      --   },
      -- }
    end,
  },
  -- Show LSP explorer of functions and classes etc.
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {},
  },

  -- Shows where you are in the file LSP wise (which class/function etc)
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
