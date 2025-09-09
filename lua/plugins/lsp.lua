-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Ensure *.templ is recognized as 'templ'
      vim.filetype.add({
        extension = { templ = "templ" },
      })

      -- Go LSP with import organization
      lspconfig.gopls.setup({
        root_dir = function(fname)
          return util.root_pattern("go.work", "go.mod", ".git")(fname)
            or util.path.dirname(fname)
        end,
        handlers = {
          -- Suppress signature help errors that are common with incomplete Go code
          ["textDocument/signatureHelp"] = function(err, result, ctx, config)
            if err and string.find(err.message, "cannot get type") then
              -- Silently ignore "cannot get type" errors for signature help
              return nil
            end
            return vim.lsp.handlers["textDocument/signatureHelp"](err, result, ctx, config)
          end,
        },
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-dist", "-build", "-out", "-coverage", "-tmp", "-.cache" },
            semanticTokens = true,
            -- Performance optimizations for large repositories
            memoryMode = "DegradeClosed",
            symbolMatcher = "FastFuzzy",
            -- Reduce signature help noise
            ["ui.completion.experimentalPostfixCompletions"] = false,
          },
        },
      })

      -- TypeScript (make sure you don't also set this up elsewhere to avoid duplicates)
      lspconfig.ts_ls.setup({})

      -- ✅ Templ LSP: auto-start when in a repo with go.mod or .git
      lspconfig.templ.setup({
        cmd = { "templ", "lsp" }, -- or absolute path if needed
        filetypes = { "templ" },
        root_dir = util.root_pattern("go.mod", ".git"),
        single_file_support = true,
      })

      -- LSP client monitoring helper
      vim.api.nvim_create_user_command('LspClients', function()
        local clients = vim.lsp.get_clients()
        local client_counts = {}
        
        for _, client in ipairs(clients) do
          client_counts[client.name] = (client_counts[client.name] or 0) + 1
        end
        
        print("=== Active LSP Clients ===")
        for name, count in pairs(client_counts) do
          local status = count > 1 and " ⚠️ DUPLICATE" or " ✅"
          print(string.format("%s: %d client(s)%s", name, count, status))
        end
        
        if next(client_counts) == nil then
          print("No active LSP clients")
        end
      end, { desc = "Show active LSP clients and detect duplicates" })

      -- Command to kill duplicate gopls clients (keep only the one with settings)
      vim.api.nvim_create_user_command('LspKillDuplicates', function()
        local gopls_clients = vim.lsp.get_clients({ name = "gopls" })
        if #gopls_clients <= 1 then
          print("No duplicate gopls clients found")
          return
        end
        
        local client_to_keep = nil
        local clients_to_kill = {}
        
        -- Find the client with the most settings (should be our configured one)
        for _, client in ipairs(gopls_clients) do
          local settings_count = 0
          if client.config.settings and client.config.settings.gopls then
            for _ in pairs(client.config.settings.gopls) do
              settings_count = settings_count + 1
            end
          end
          
          if settings_count > 0 and not client_to_keep then
            client_to_keep = client
          else
            table.insert(clients_to_kill, client)
          end
        end
        
        -- Kill the duplicates
        for _, client in ipairs(clients_to_kill) do
          print(string.format("Killing duplicate gopls client (id: %d)", client.id))
          client.stop(true)
        end
        
        if client_to_keep then
          print(string.format("Kept gopls client (id: %d) with settings", client_to_keep.id))
        end
      end, { desc = "Kill duplicate gopls clients" })

      -- Safe hover helper
      local function has_hover(bufnr)
        for _, c in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if c.server_capabilities and c.server_capabilities.hoverProvider then
            return true
          end
        end
        return false
      end

      -- LSP keymaps are handled in lsp-keymaps.lua
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          
          -- Use the centralized keymap system
          local lsp_keymaps = require('plugins.lsp-keymaps')
          lsp_keymaps.on_attach(nil, bufnr)
          
          -- Safe hover (keeping this custom logic)
          local function buf_map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          
          buf_map("n", "K", function()
            if not has_hover(bufnr) then
              return
            end
            local ok, saga_hover = pcall(require, "lspsaga.hover")
            if ok and saga_hover and saga_hover.render_hover_doc then
              pcall(function() saga_hover:render_hover_doc() end)
            else
              pcall(vim.lsp.buf.hover)
            end
          end, "LSP: Hover (safe)")
        end,
      })
    end,
  },
}

