local keymap = vim.keymap.set
local trouble = require("trouble")

vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function()
        vim.diagnostic.setqflist({ open = false })
        vim.diagnostic.setloclist({ open = false })
    end,
})

function QuickFixToggle()
    if trouble.is_open() then
        trouble.close()
    else
        trouble.open({
            mode = "quickfix"
        })
    end
end

function LocationListToggle()
    if trouble.is_open() then
        trouble.close()
    else
        trouble.open({
            mode = "loclist"
        })
    end
end

-- Quickfix
keymap("n", "<leader>qq", ":lua QuickFixToggle()<CR>", { desc = "[Q]uickfix [Q]uick" })
keymap("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "[Q]uick [N]ext" })
keymap("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "[Q]uick [P]revious" })

-- Location List
keymap("n", "<leader>ll", ":lua LocationListToggle()<CR>", { desc = "[L]ocation [L]ist" })
keymap("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = "[L]ocation [N]ext" })
keymap("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = "[L]ocation [P]revious" })
