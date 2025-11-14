-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      ---------------------------------------------------------------------------
      -- LSP client utilities
      ---------------------------------------------------------------------------
      vim.api.nvim_create_user_command("LspClients", function()
        -- new API: vim.lsp.get_clients
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

      vim.api.nvim_create_user_command("LspKillDuplicates", function()
        -- only worry about duplicate gopls, since that’s your main concern
        local gopls_clients = vim.lsp.get_clients({ name = "gopls" })
        if #gopls_clients <= 1 then
          print("No duplicate gopls clients found")
          return
        end

        local client_to_keep = nil
        local clients_to_kill = {}

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

        for _, client in ipairs(clients_to_kill) do
          print(string.format("Killing duplicate gopls client (id: %d)", client.id))
          client.stop(true)
        end

        if client_to_keep then
          print(string.format("Kept gopls client (id: %d) with settings", client_to_keep.id))
        end
      end, { desc = "Kill duplicate gopls clients" })

      ---------------------------------------------------------------------------
      -- Hover safety + keymaps
      ---------------------------------------------------------------------------
      local function has_hover(bufnr)
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        for _, c in pairs(clients) do
          if c.server_capabilities and c.server_capabilities.hoverProvider then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local lsp_keymaps = require("plugins.lsp-keymaps")
          lsp_keymaps.on_attach(nil, bufnr)

          local function buf_map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- K = hover (safe)
          buf_map("n", "K", function()
            if not has_hover(bufnr) then
              return
            end
            local ok, saga_hover = pcall(require, "lspsaga.hover")
            if ok and saga_hover and saga_hover.render_hover_doc then
              pcall(function()
                saga_hover:render_hover_doc()
              end)
            else
              pcall(vim.lsp.buf.hover)
            end
          end, "LSP: Hover (safe)")
        end,
      })
    end,
  },
}

