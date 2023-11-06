-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>')


function on_text_search()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    vim.cmd("Telescope live_grep search_dirs=" .. node.absolute_path)
end

function folder_search(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<Space>st",
        "<cmd>lua on_text_search()<CR>",
        { silent = false, nowait = true }
    )
end

function NvimTreeWidth()
    local winwidth = vim.fn.winwidth(0)
    if winwidth <= 100 then
        return 30
    elseif winwidth <= 200 then
        return 40
    else
        return 50
    end
end

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        on_attach = folder_search,

        auto_reload_on_write = false,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        sort_by = "name",
        root_dirs = {},
        prefer_startup_root = false,
        sync_root_with_cwd = true,
        reload_on_bufenter = false,
        respect_buf_cwd = false,
        select_prompts = false,
        view = {
            adaptive_size = false,
            centralize_selection = true,
            width = NvimTreeWidth(),
            hide_root_folder = false,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            float = {
                enable = false,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = true,
            full_name = false,
            highlight_opened_files = "none",
            root_folder_label = ":t",
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },
        hijack_directories = {
            enable = false,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            debounce_delay = 15,
            update_root = true,
            ignore_list = {},
        },
        -- diagnostics = {
        --     enable = lvim.use_icons,
        --     show_on_dirs = false,
        --     show_on_open_dirs = true,
        --     debounce_delay = 50,
        --     severity = {
        --         min = vim.diagnostic.severity.HINT,
        --         max = vim.diagnostic.severity.ERROR,
        --     },
        --     icons = {
        --         hint = lvim.icons.diagnostics.BoldHint,
        --         info = lvim.icons.diagnostics.BoldInformation,
        --         warning = lvim.icons.diagnostics.BoldWarning,
        --         error = lvim.icons.diagnostics.BoldError,
        --     },
        -- },
        filters = {
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            -- custom = { "node_modules", "\\.cache" },
            custom = { "\\.cache" },
            exclude = {},
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
            ignore_dirs = {},
        },
        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 200,
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            expand_all = {
                max_folder_discovery = 300,
                exclude = {},
            },
            file_popup = {
                open_win_config = {
                    col = 1,
                    row = 1,
                    relative = "cursor",
                    border = "shadow",
                    style = "minimal",
                },
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    picker = "default",
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },
        tab = {
            sync = {
                open = false,
                close = false,
                ignore = {},
            },
        },
        notify = {
            threshold = vim.log.levels.INFO,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },
        system_open = {
            cmd = nil,
            args = {},
        },
    },
}
