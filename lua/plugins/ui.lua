--[plugins/ui.lua]

return {
    { -- Colorscheme (Tokyonight)
        'folke/tokyonight.nvim',
        priority = 1000,
        opts = {
            style = "night",       -- "storm" | "night" | "moon" | "day"
            transparent = true,    -- enable transparent background
            styles = {
                sidebars = "transparent", -- sidebar-like windows
                floats = "transparent",   -- floating windows
            },
        },
        config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme 'tokyonight-night'
        vim.cmd.hi 'Comment gui=none'

        -- Toggle transparency function
        function Toggle_transparent()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if normal.bg == nil then
            require("tokyonight").setup({ transparent = false })
            vim.cmd.colorscheme("tokyonight-night")
            vim.cmd.hi("Comment gui=none")
            else
                require("tokyonight").setup({ transparent = true })
                vim.cmd.colorscheme("tokyonight-night")
                vim.cmd.hi("Comment gui=none")
                end
                end

                -- Keymap: <leader>ut = toggle transparency
                vim.keymap.set("n", "<leader>ut", Toggle_transparent, { desc = "[U]I [T]ransparency toggle" })

                --[[
                -- Manual highlights if you want to force extra groups transparent
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
                vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
                vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
                ]]
                end,
    },


    { -- Evil Lualine (statusline)
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
        require('lualine').setup {
            options = {
                theme = 'tokyonight',
                icons_enabled = true,
                component_separators = { left = '│', right = '│' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        }
        end,
    },

    { -- Bufferline (tabs at the top)
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
        config = function()
        require("bufferline").setup {
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",
                separator_style = "slant",
                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                    },
                },
            },
            highlights = require("tokyonight.groups").bufferline,
        }

        -- Optional: dim inactive buffers
        vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#565f89", bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = "#565f89", bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#c0caf5", bg = "#1f2335", bold = true })
        end,
    },
}
