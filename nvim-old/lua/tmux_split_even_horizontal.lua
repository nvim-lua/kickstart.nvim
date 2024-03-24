local M = {}

function M.tmux_split_even_horizontal()
    local status, err = pcall(function()
        local filepath = vim.fn.expand('%:p')
        if filepath ~= '' then
            local tmux_command = "tmux split-window -h -c '" .. vim.fn.expand('%:p:h') ..
                                 "' && tmux send-keys -t '.tmux.active-pane' 'nvim " ..
                                 vim.fn.shellescape(filepath) .. "' Enter && tmux select-layout even-horizontal"
            vim.fn.system(tmux_command)
        end
    end)
    if not status then
        print("Error in tmux_split_even_horizontal: " .. err)
    end
end

return M

