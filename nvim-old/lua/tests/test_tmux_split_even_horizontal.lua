-- Mock setup
_G.vim = {
    wo = {},  -- Window-scoped options
    bo = {},  -- Buffer-scoped options
    -- Add more fields as needed
}

-- Example usage in a test case
describe("My Neovim Function", function()
    it("does something", function()
        -- Test code that uses the mock `vim` object
    end)
end)

local tmux_split_even_horizontal = require('tmux_split_even_horizontal')

describe("tmux_split_even_horizontal", function()
    local tmux_split_even_horizontal = require('tmux_split_even_horizontal')

    it("should not throw errors", function()
        assert.has_no.errors(function()
            tmux_split_even_horizontal.tmux_split_even_horizontal()
        end)
    end)

    -- Additional tests can be added here
end)

