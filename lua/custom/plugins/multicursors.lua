-- Register plugin
vim.pack.add({
    "https://github.com/jake-stewart/multicursor.nvim.git",
})

vim.api.nvim_create_user_command("LoadMultiCursor", function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<Up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<Down>", function() mc.lineAddCursor(1) end)
    set({ "n", "x" }, "<leader><Up>", function() mc.lineSkipCursor(-1) end)
    set({ "n", "x" }, "<leader><Down>", function() mc.lineSkipCursor(1) end)

    -- Add or skip adding a new cursor by matching word/selection.
    set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
    set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
    set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
    set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

    -- Add and remove cursors with Ctrl+Mouse.
    set("n", "<C-LeftMouse>", mc.handleMouse)
    set("n", "<C-LeftDrag>", mc.handleMouseDrag)
    set("n", "<C-LeftRelease>", mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({ "n", "x" }, "<C-q>", mc.toggleCursor)

    mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<Right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<Esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.clearCursors()
            end
        end)
    end)

    -- Highlight groups.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

    print("multicursor.nvim loaded successfully!")
end, {})
