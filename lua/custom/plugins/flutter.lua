return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require('flutter-tools').setup {
            debugger = {
                enabled = true,
                exception_breakpoints = {},
                run_via_dap = true,
                register_configurations = function(paths)
                    require("dap").configurations.dart = {
                        require("dap.ext.vscode").load_launchjs()
                    }
            end,
            },
            widget_guides = {
                enabled = true,
                debug = true
            },
            lsp = {
                color = { -- show the derived colours for dart variables
                    enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                    background = false, -- highlight the background
                    virtual_text = true, -- show the highlight using virtual text
                },
            },
            settings = {
                showTodos = true,
                completeFunctionCalls = true,
                analysisExcludedFolders = { ".dart_tool", },
            },
            fvm = true
        }
    end
}