-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local configs = require("lspconfig.configs")

      -- Recognize .templ files
      vim.filetype.add({ extension = { templ = "templ" } })

      -- ==============================
      -- gopls
      -- ==============================
      lspconfig.gopls.setup({
        root_dir = function(fname)
          return util.root_pattern("go.work", "go.mod", ".git")(fname)
            or util.path.dirname(fname)
        end,
        handlers = {
          ["textDocument/signatureHelp"] = function(err, result, ctx, config)
            if err and err.message and err.message:find("cannot get type") then
              return
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
            directoryFilters = {
              "-.git","-.vscode","-.idea","-.vscode-test","-node_modules",
              "-dist","-build","-out","-coverage","-tmp","-.cache",
            },
            semanticTokens = true,
            memoryMode = "DegradeClosed",
            symbolMatcher = "FastFuzzy",
            ["ui.completion.experimentalPostfixCompletions"] = false,
          },
        },
      })

      -- ==============================
      -- TypeScript / JavaScript (ts_ls OR tsserver fallback)
      -- ==============================
      local ts_server = lspconfig.ts_ls or lspconfig.tsserver
      if ts_server then
        ts_server.setup({})
      end

      -- ==============================
      -- Astro (guard if missing)
      -- ==============================
      if lspconfig.astro then
        local function get_typescript_lib()
          local mason_ts = vim.fs.normalize(
            "~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
          )
          if vim.fn.isdirectory(mason_ts) == 1 then return mason_ts end

          local global_ts = (vim.fn.system("npm root -g"):gsub("\n", "")) .. "/typescript/lib"
          if vim.fn.isdirectory(global_ts) == 1 then return global_ts end

          return vim.fs.normalize(
            "~/.local/share/nvim/mason/packages/astro-language-server/node_modules/typescript/lib"
          )
        end

        lspconfig.astro.setup({
          init_options = { typescript = { tsdk = get_typescript_lib() } },
        })
      end

      -- ==============================
      -- templ (register config if missing)
      -- ==============================
      if not configs.templ then
        configs.templ = {
          default_config = {
            cmd = { "templ", "lsp" },
            filetypes = { "templ" },
            root_dir = util.root_pattern("go.mod", ".git"),
            single_file_support = true,
          },
        }
      end
      lspconfig.templ.setup({})

      -- ==============================
      -- Utilities
      -- ==============================
      vim.api.nvim_create_user_command("LspClients", function()
        local clients = vim.lsp.get_clients()
        local counts = {}
        for _, c in ipairs(clients) do
          counts[c.name] = (counts[c.name] or 0) + 1
        end
        print("=== Active LSP Clients ===")
        for name, n in pairs(counts) do
          local dup = n > 1 and " ⚠️ DUPLICATE" or " ✅"
          print(string.format("%s: %d client(s)%s", name, n, dup))
        end
        if next(counts) == nil then print("No active LSP clients") end
      end, {})

      vim.api.nvim_create_user_command("LspKillDuplicates", function()
        local gopls_clients = vim.lsp.get_clients({ name = "gopls" })
        if #gopls_clients <= 1 then
          print("No duplicate gopls clients found")
          return
        end
        local keep, kill = nil, {}
        for _, c in ipairs(gopls_clients) do
          local cnt = 0
          if c.config.settings and c.config.settings.gopls then
            for _ in pairs(c.config.settings.gopls) do cnt = cnt + 1 end
          end
          if cnt > 0 and not keep then keep = c else table.insert(kill, c) end
        end
        for _, c in ipairs(kill) do
          print(("Killing duplicate gopls client (id: %d)"):format(c.id))
          c.stop(true)
        end
        if keep then print(("Kept gopls client (id: %d) with settings"):format(keep.id)) end
      end, {})

      local function has_hover(bufnr)
        for _, c in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if c.server_capabilities and c.server_capabilities.hoverProvider then return true end
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

          buf_map("n", "K", function()
            if not has_hover(bufnr) then return end
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

