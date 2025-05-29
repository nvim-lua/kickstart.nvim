-- filepath: /home/kali/.config/nvim/lua/custom/plugins/copilot-chat.lua
-- GitHub Copilot Chat configuration
-- An advanced setup for Copilot Chat in Neovim
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

-- Declare vim as global
local vim = vim

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main", -- Ensure we're using the stable main branch
  dependencies = {
    -- Dependencies for CopilotChat
    { "github/copilot.vim" },        -- The base Copilot plugin
    { "nvim-lua/plenary.nvim" },     -- Common Lua functions
    { "nvim-telescope/telescope.nvim" }, -- For nice UI integration
    { "nvim-tree/nvim-web-devicons" }, -- Icons for enhanced UI
  },
  -- Load after GitHub Copilot and when a file is opened
  event = { "VeryLazy" },
  
  config = function()
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")
    
    -- Configure the plugin with advanced settings
    chat.setup({
      -- Show Copilot Chat window border
      window = {
        border = "rounded", -- Make the window look nice
        width = 80,        -- Default width
        height = 20,       -- Default height
        title = {
          name = "Copilot Chat", -- Custom title
          alignment = "center",  -- Center the title
        },
      },
      
      -- File context features
      context = {
        -- Include 5 lines above and below the cursor for context
        cursor_context = 5,
        
        -- Include the entire selection when using visual mode
        selection_context = true,
        
        -- Show context-aware commit history
        git_context = true,
      },
      
      -- Enable debug (set to true only when troubleshooting)
      debug = false,
      
      -- Enable syntax highlighting in response
      syntax_highlighting = true,
      
      -- Enable auto-sizing of response window
      auto_size = true,
      
      -- Define prompts that can be used in commands
      prompts = {
        -- Default prompts
        Explain = {
          prompt = "Explain how the following code works in detail:\n```$filetype\n$selection\n```",
        },
        FixCode = {
          prompt = "Fix the following code. Provide the corrected version and explanations for the fixes:\n```$filetype\n$selection\n```",
        },
        Optimize = {
          prompt = "Optimize the following code. Provide the optimized version and explain the improvements:\n```$filetype\n$selection\n```",
        },
        -- Advanced prompts
        Documentation = {
          prompt = "Generate comprehensive documentation for this code:\n```$filetype\n$selection\n```\nInclude descriptions of parameters, return values, exceptions, and provide usage examples.",
        },
        BestPractices = {
          prompt = "Review this code for best practices and suggest improvements:\n```$filetype\n$selection\n```",
        },
        Tests = {
          prompt = "Generate unit tests for the following code:\n```$filetype\n$selection\n```",
        },
        -- Context-aware code generation
        Implement = {
          prompt = "Implement the following functionality: $input\nMake it work with the following context:\n```$filetype\n$selection\n```",
          strategy = "quick_fix", -- Use the quick fix strategy for implementation
        },
        RefactorToPattern = {
          prompt = "Refactor the following code to use the $input design pattern. Explain the benefits of this refactoring:\n```$filetype\n$selection\n```",
        },
      },
    })
    
    -- Add custom keymaps for the chat buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "copilot-chat",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        
        -- Close window with 'q'
        vim.keymap.set("n", "q", function()
          vim.cmd("close")
        end, { buffer = buf, silent = true })
        
        -- Reset chat with Ctrl+L
        vim.keymap.set("n", "<C-l>", function()
          chat.reset()
        end, { buffer = buf, silent = true })
        
        -- -- Submit prompt with Enter in insert mode
        -- vim.keymap.set("i", "<CR>", function()
        --   -- require("CopilotChat").submit_prompt()
        --   chat.submit_prompt()
        -- end, { buffer = buf, silent = true })
        
        -- -- Submit prompt with Enter in normal mode
        -- vim.keymap.set("n", "<CR>", function()
        --   require("CopilotChat").submit_prompt()
        -- end, { buffer = buf, silent = true })
        
        -- Show diff with Ctrl+D
        vim.keymap.set("n", "<C-d>", function()
          require("CopilotChat").show_diff()
        end, { buffer = buf, silent = true })
        
        -- Accept diff with Ctrl+Y
        vim.keymap.set("n", "<C-y>", function()
          require("CopilotChat").accept_diff()
        end, { buffer = buf, silent = true })
      end
    })
    
    -- Set up key bindings
    vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Copilot Chat" })
    vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Explain Code" })
    vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFixCode<CR>", { desc = "Fix Code" })
    vim.keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "Optimize Code" })
    vim.keymap.set("n", "<leader>cd", "<cmd>CopilotChatDocumentation<CR>", { desc = "Generate Documentation" })
    vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate Tests" })
    vim.keymap.set("n", "<leader>cb", "<cmd>CopilotChatBestPractices<CR>", { desc = "Check Best Practices" })
    
    -- Visual mode mappings for selected code
    vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain Selected Code" })
    vim.keymap.set("v", "<leader>cf", ":CopilotChatFixCode<CR>", { desc = "Fix Selected Code" })
    vim.keymap.set("v", "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Optimize Selected Code" })
    vim.keymap.set("v", "<leader>cd", ":CopilotChatDocumentation<CR>", { desc = "Document Selected Code" })
    vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Generate Tests for Selected Code" })
    
    -- Create a custom input command with implementation suggestions
    vim.keymap.set("v", "<leader>ci", function()
      vim.ui.input({ prompt = "What would you like to implement? " }, function(input)
        if input then
          select.selection()
          chat.ask("Implement: " .. input)
        end
      end)
    end, { desc = "Implement Functionality" })
    
    -- Add quick access to buffer context
    vim.keymap.set("n", "<leader>cb", function()
      chat.ask("What does this code do? Consider the full context of the file.", {
        selection = select.buffer,
      })
    end, { desc = "Explain Buffer" })
    
    -- Refactor the current selection to use a specific design pattern
    vim.keymap.set("v", "<leader>cr", function()
      vim.ui.input({ prompt = "Which design pattern to refactor to? " }, function(input)
        if input then
          select.selection()
          chat.ask("RefactorToPattern: " .. input)
        end
      end)
    end, { desc = "Refactor to Design Pattern" })
    
    -- Toggle inline chat for quick questions about the current line
    vim.keymap.set("n", "<leader>cl", function()
      select.line()
      chat.toggle()
    end, { desc = "Chat About Current Line" })
    
    -- Open Copilot Chat with a custom prompt
    vim.keymap.set("n", "<leader>cp", function()
      vim.ui.input({ prompt = "Ask Copilot: " }, function(input)
        if input then
          chat.ask(input)
        end
      end)
    end, { desc = "Ask Copilot" })
  end,
}
