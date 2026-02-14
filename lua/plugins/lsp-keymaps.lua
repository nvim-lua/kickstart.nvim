-- lua/plugins/lsp-keymaps.lua
return {
  -- Attach to the existing LSP config plugin
  "neovim/nvim-lspconfig",

  -- We just need this to run once; inside we create an LspAttach autocmd
  event = "VeryLazy",

  config = function()
    local group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(ev)
        local bufnr = ev.buf

        -- Helper to build opts for this buffer
        local function opts(desc)
          return {
            buffer = bufnr,
            silent = true,
            noremap = true,
            desc = desc,
          }
        end

        -- Smarter "go to definition":
        -- - Ask for definition
        -- - If it points to an import line in the same file, fall back to implementation
        local function goto_definition_preferring_source()
          local params = vim.lsp.util.make_position_params()

          local function jump_to(loc)
            if not loc then return end
            vim.lsp.util.jump_to_location(loc, "utf-8")
          end

          vim.lsp.buf_request(bufnr, "textDocument/definition", params, function(err, result)
            if err or not result then
              return
            end

            local locations = result
            if not vim.tbl_islist(locations) then
              locations = { locations }
            end
            if #locations == 0 then
              return
            end

            local first = locations[1]
            local uri = first.uri or first.targetUri
            local range = first.range or first.targetRange

            if not (uri and range) then
              return jump_to(first)
            end

            local def_bufnr = vim.uri_to_bufnr(uri)
            local cur_bufnr = bufnr

            -- If TS says "definition is this import in the same file", try implementation instead.
            if def_bufnr == cur_bufnr then
              local line_nr = range.start.line
              local line = vim.api.nvim_buf_get_lines(def_bufnr, line_nr, line_nr + 1, false)[1] or ""
              if line:match("^%s*import") then
                vim.lsp.buf_request(bufnr, "textDocument/implementation", params, function(err2, impl)
                  if err2 or not impl then
                    return jump_to(first)
                  end
                  local impl_locs = impl
                  if not vim.tbl_islist(impl_locs) then
                    impl_locs = { impl_locs }
                  end
                  jump_to(impl_locs[1] or first)
                end)
                return
              end
            end

            jump_to(first)
          end)
        end

        -- Core LSP maps
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<CR>", opts("LSP Info"))

        vim.keymap.set("n", "gr", vim.lsp.buf.references,      opts("References"))
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation,  opts("Go to Implementation"))
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts("Go to Type Definition"))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     opts("Go to Declaration"))
        vim.keymap.set("n", "gd", goto_definition_preferring_source, opts("Go to Definition"))
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help,  opts("Signature Help"))

        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))

        -- Rename symbol
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename"))

        -- Rename file via Snacks, but safely
        vim.keymap.set("n", "<leader>cR", function()
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks.rename and snacks.rename.rename_file then
            snacks.rename.rename_file()
          else
            print("Snacks rename not available")
          end
        end, opts("Rename File"))
      end,
    })
  end,
}

