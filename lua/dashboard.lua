-- lua/dashboard.lua
local snacks = require("plugins.tools")
local M = {}

M.config = {
    enabled = true,
    width = 60,
    row = nil,
    col = nil,
    pane_gap = 4,
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

    preset = {
        pick = nil,
        keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },

        -- Keep NEOVIM header at top center
        header = [[
            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },

    formats = {
        icon = function(item)
        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok and item.file and (item.icon == "file" or item.icon == "directory") then
            local icon, hl = devicons.get_icon(item.file, nil, { default = true })
            return { icon, width = 2, hl = hl }
            end
            return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                    file = file:sub(-(ctx.width - #dir - 2))
                    fname = dir .. "/…" .. file
                    end
                    end
                    local dir, file = fname:match("^(.*)/(.+)$")
                    return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
                    or { { fname, hl = "file" } }
                    end,
    },

    sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },

        -- Browse Repo section (single instance)
        {
            pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            enabled = function()
            return require("snacks").git.get_root() ~= nil
            end,
            action = function()
            local ok, err = pcall(function()
            require("snacks").gitbrowse()
            end)
            if not ok then
                vim.notify("Not in a git repository or gitbrowse failed: " .. tostring(err), vim.log.levels.WARN)
                end
                end,
        },

        -- Git/GitHub terminal sections (single function)
        function()
        local git_root = require("snacks").git.get_root()
        local in_git = git_root ~= nil
        local has_gh = vim.fn.executable("gh") == 1

        local cmds = {
            {
                title = "Notifications",
                icon = " ",
                cmd = has_gh and "gh notify -s -a -n5" or "echo 'gh CLI not available'",
                action = function()
                if has_gh then
                    vim.ui.open("https://github.com/notifications")
                    else
                        vim.notify("GitHub CLI not installed", vim.log.levels.WARN)
                        end
                        end,
                        key = "n",
                        height = 5,
            },
            {
                title = "Open Issues",
                icon = " ",
                cmd = has_gh and "gh issue list -L 3" or "echo 'gh CLI not available'",
                key = "i",
                action = function()
                if has_gh then
                    vim.fn.jobstart("gh issue list --web", { detach = true })
                    else
                        vim.notify("GitHub CLI not installed", vim.log.levels.WARN)
                        end
                        end,
                        height = 8,
            },
            {
                title = "Open PRs",
                icon = " ",
                cmd = has_gh and "gh pr list -L 2" or "echo 'gh CLI not available'",
                key = "p",
                action = function()
                if has_gh then
                    vim.fn.jobstart("gh pr list --web", { detach = true })
                    else
                        vim.notify("GitHub CLI not installed", vim.log.levels.WARN)
                        end
                        end,
                        height = 6,
            },
            {
                title = "Git Status",
                icon = " ",
                cmd = "git status --porcelain=v1 2>/dev/null | head -5",
                key = "g",
                height = 6,
            },
        }

        return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
            pane = 2,
            section = "terminal",
            enabled = in_git,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
        }, cmd)
        end, cmds)
        end,

        { section = "startup" },
    }
}

return M
