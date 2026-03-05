---@diagnostic disable: undefined-global
-- Direct approach to fix hover documentation with custom function
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Create a direct standalone hover function
    local function better_hover()
      -- Save original functions we'll temporarily override
      local orig_open_floating = vim.lsp.util.open_floating_preview
      
      -- Replace the floating preview function temporarily
      vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
        opts = opts or {}
        -- Force nicer styling
        opts.border = "rounded"
        opts.max_width = math.min(math.floor(vim.o.columns * 0.7), 80)
        opts.max_height = math.floor(vim.o.lines * 0.3)
        
        -- Process contents to remove separator lines and improve formatting
        local cleaned_contents = {}
        for _, line in ipairs(contents) do
          -- Skip separator lines
          if not line:match("^%-%-%-%-+$") then
            table.insert(cleaned_contents, line)
          end
        end
        
        -- Call original with improved options and cleaned content
        local bufnr, winnr = orig_open_floating(cleaned_contents, syntax, opts)
        
        -- Enhance the created buffer
        if bufnr and winnr then
          -- Set better options for the window
          vim.api.nvim_win_set_option(winnr, "conceallevel", 2)
          vim.api.nvim_win_set_option(winnr, "foldenable", false)
          
          -- If it's markdown, ensure proper highlighting
          if syntax == "markdown" then
            vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
          end
        end
        
        return bufnr, winnr
      end
      
      -- Call the regular hover function with our temporary override
      vim.lsp.buf.hover()
      
      -- Restore original function
      vim.lsp.util.open_floating_preview = orig_open_floating
    end
    
    -- Directly override the K keymap - this bypasses any conflicts
    vim.keymap.set("n", "K", better_hover, { noremap = true, silent = true, desc = "LSP: Better hover docs" })
  end,
  -- Run this after all other LSP configs are loaded
  priority = 999,
}
