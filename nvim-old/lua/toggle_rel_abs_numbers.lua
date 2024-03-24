local M = {}  -- Create a local table M to hold the module's functions

-- Function to toggle line numbers between relative and absolute
function M.toggle_line_numbers()
    local status, err = pcall(function()
        -- Use pcall to catch any errors in the following block
        if vim.wo.relativenumber then
            -- If relative line numbers are on, turn them off and ensure absolute numbers are on
            vim.wo.relativenumber = false
            vim.wo.number = true
        else
            -- If relative line numbers are off, turn them on (absolute numbers stay on)
            vim.wo.relativenumber = true
            vim.wo.number = true
        end
    end)
    if not status then
        -- If there was an error, print it
        print("Error in toggle_line_numbers: " .. err)
    end
end

return M  -- Return the table containing the module's functions
