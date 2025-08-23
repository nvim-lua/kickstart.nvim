--[plugins/lsp.lua]

return {
    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
        -- The config function is now INSIDE the table, where it belongs
        config = function()
        -- This function checks if the LSP server executable is in a trusted path.
        local function start_trusted_lsp(config)
        -- List of trusted paths for LSP executables.
        local trusted_paths = {
            '/usr/bin/',
            '/usr/local/bin/',
            '/nix/var/nix/profiles/default/bin/',
            '/home/lyniks0611/.nix-profile/bin/', -- Your specific Nix path
            vim.fn.stdpath('data') .. '/mason/bin/', -- Trust executables installed by Mason
        }

        local cmd = config.cmd[1]
        local is_trusted = false
        for _, path in ipairs(trusted_paths) do
            if vim.startswith(cmd, path) then
                is_trusted = true
                break
                end
                end

                if not is_trusted then
                    vim.ui.select({ 'Yes', 'No' }, {
                        prompt = 'LSP: Trust and run this executable? ' .. cmd,
                    }, function(choice)
                    if choice == 'Yes' then
                        vim.lsp.start(config)
                        end
                        end)
                    else
                        vim.lsp.start(config)
                        end
                        end

                        vim.api.nvim_create_autocmd('LspAttach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                                                    callback = function(event)
                                                    local map = function(keys, func, desc, mode)
                                                    mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                        end

                        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

                            vim.api.nvim_create_autocmd('LspDetach', {
                                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                                                        callback = function(event2)
                                                        vim.lsp.buf.clear_references()
                                                        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                                                        end,
                            })
                            end

                            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                                map('<leader>th', function()
                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                                end, '[T]oggle Inlay [H]ints')
                                end
                                end,
                        })

                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

                        local servers = {
                            clangd = {},
                            pyright = {},
                            jsonls = {},
                            yamlls = {},
                            ts_ls = {},

                            lua_ls = {
                                settings = {
                                    Lua = {
                                        completion = {
                                            callSnippet = 'Replace',
                                        },
                                        diagnostics = {
                                            globals = { 'vim' },
                                        },
                                        workspace = {
                                            library = vim.api.nvim_get_runtime_file('', true),
                                            checkThirdParty = false,
                                        },
                                    },
                                },
                            },
                        }

                        require('mason').setup()

                        local ensure_installed = vim.tbl_keys(servers or {})
                        vim.list_extend(ensure_installed, {
                            'stylua',
                        })
                        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

                        require('mason-lspconfig').setup {
                            handlers = {
                                function(server_name)
                                local server = servers[server_name] or {}
                                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                                server.cmd_hook = function(config)
                                start_trusted_lsp(config)
                                end

                                require('lspconfig')[server_name].setup(server)
                                end,
                            },
                        }
                        end,
    },
}
