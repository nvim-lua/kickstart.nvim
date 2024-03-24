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

describe("toggle_line_numbers", function()
    local toggle_line_numbers

    -- Mock setup before each test
    before_each(function()
        _G.vim = { wo = { relativenumber = false, number = false } }
        package.loaded['toggle_rel_abs_numbers'] = nil  -- Unload the module
        toggle_line_numbers = require('toggle_rel_abs_numbers').toggle_line_numbers
    end)

    it("toggles from relative to absolute line numbers", function()
        toggle_line_numbers()
        assert.is_true(vim.wo.relativenumber)
        assert.is_true(vim.wo.number)

        toggle_line_numbers()
        assert.is_false(vim.wo.relativenumber)
        assert.is_true(vim.wo.number)
    end)
end)

