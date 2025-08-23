-- lua/dashboard.lua

-- FIX: Require snacks at the top to make it available in this file's scope
local snacks = require("snacks")
local M = {}

M.config = {
    enabled = true,
    width = 60,
    row = nil, -- dashboard position. nil for center
    col = nil, -- dashboard position. nil for center
    pane_gap = 4, -- empty columns between vertical panes
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

    preset = {
        pick = nil,
        keys = {
            -- FIX: Changed actions from strings to functions and used the correct 'snacks' variable
            { icon = " ", key = "f", desc = "Find File", action = function() snacks.dashboard.pick("files") end },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = function() snacks.dashboard.pick("live_grep") end },
            { icon = " ", key = "r", desc = "Recent Files", action = function() snacks.dashboard.pick("oldfiles") end },
            {
                icon = " ",
                key = "c",
                desc = "Config",
                action = function() snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end,
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },

    formats = {
        -- FIX: The M.icon function was not defined.
        -- This now returns the default icon to prevent errors.
        -- For custom icons, you would need to implement this, for example using nvim-web-devicons:
        -- return require("nvim-web-devicons").get_icon(item.file, item.icon)
        icon = function(item)
        if item.file and (item.icon == "file" or item.icon == "directory") then
            -- Placeholder to avoid error. Implement your icon logic here.
            local ok, devicons = pcall(require, "nvim-web-devicons")
            if ok then
                local icon, hl = devicons.get_icon(item.file, nil, { default = true })
                return { icon, width = 2, hl = hl }
                end
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
                        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
                        end,
    },

    -- Replace your old 'sections' table with this one
    sections = {
        -- Header (spans all columns)
        { section = "header" },
        { section = "startup", padding = { 0, 0, 1, 0 } }, -- Adds a small gap below the header

        -----------------------------------
        -- PANE 1: Left Column
        -----------------------------------

        -- Pokemon sprite at the top-left
        {
            pane = 1, -- MOVED from pane 3
            section = "terminal",
            cmd = "pokemon-colorscripts -r --no-title; sleep .1",
            random = 10,
            height = 15, -- Adjust height as needed
            padding = 2,
            indent = 4,
        },

        -- File commands below the sprite
        {
            pane = 1, -- MOVED to pane 1
            section = "keys",
            gap = 1,
            padding = { 2, 3 }, -- top/bottom, left/right
        },

        -----------------------------------
        -- PANE 2: Right Column
        -----------------------------------

        -- "Browse Repo" button at the top-right
        {
            pane = 2, -- Stays in pane 2
            icon = " ",
            desc = "Browse Repo",
            padding = { 1, 0 },
            key = "b",
            action = function() require("snacks").gitbrowse() end,
        },

        -- All GitHub sections (Notifications, Issues, PRs)
        function()
        local in_git = require("snacks").git.get_root() ~= nil
        local cmds = {
            {
                title = "Notifications",
                cmd = "gh notify -s -a -n5",
                action = function() vim.ui.open("https://github.com/notifications") end,
                key = "n",
                height = 5,
            },
            {
                title = "Open Issues",
                cmd = "gh issue list -L 5",
                key = "i",
                action = function() vim.fn.jobstart("gh issue list --web", { detach = true }) end,
                height = 7,
            },
            {
                title = "Open PRs",
                cmd = "gh pr list -L 5",
                key = "p",
                action = function() vim.fn.jobstart("gh pr list --web", { detach = true }) end,
                height = 7,
            },
        }
        return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
            pane = 2, -- IMPORTANT: Ensures all these are in the right column
            section = "terminal",
            enabled = in_git,
            padding = 1,
            ttl = 5 * 60, -- Refresh every 5 minutes
            indent = 3,
        }, cmd)
        end, cmds)
        end,
    },
}

return M
