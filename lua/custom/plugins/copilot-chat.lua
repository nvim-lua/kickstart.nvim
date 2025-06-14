--gitHub Copilot Chat configuration - Latest v3+ setup
-- Comprehensive configuration with all features and working keymaps
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  event = "VeryLazy",
  
  config = function()
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")
    
    -- Setup CopilotChat with comprehensive configuration
    chat.setup({
      -- Model configuration
      model = 'gpt-4.1', -- Default model to use, see ':CopilotChatModels' for available models
      agent = 'copilot', -- Default agent to use, see ':CopilotChatAgents' for available agents
      context = nil, -- Default context or array of contexts to use
      
      -- Temperature for GPT responses (0.1 = more focused, 1.0 = more creative)
      temperature = 0.1,
      
      -- Window configuration
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.5, -- fractional width of parent
        height = 0.5, -- fractional height of parent
        -- Options for floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'rounded', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
        title = 'Copilot Chat',
        footer = nil,
        zindex = 1,
      },
      
      -- UI settings
      show_help = true, -- Shows help message as virtual lines when waiting for user input
      highlight_selection = true, -- Highlight selection in source buffer
      highlight_headers = true, -- Highlight headers in chat
      auto_follow_cursor = true, -- Auto-follow cursor in chat
      auto_insert_mode = false, -- Automatically enter insert mode when opening window
      insert_at_end = false, -- Move cursor to end of buffer when inserting text
      clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
      
      -- Chat features
      chat_autocomplete = true, -- Enable chat autocompletion
      
      -- Default selection (uses visual selection or falls back to buffer)
      selection = function(source)
        return select.visual(source) or select.buffer(source)
      end,
      
      -- Custom prompts for various coding tasks
      prompts = {
        -- Code explanation
        Explain = {
          prompt = 'Write an explanation for the selected code as paragraphs of text.',
          system_prompt = 'COPILOT_EXPLAIN',
        },
        
        -- Code review
        Review = {
          prompt = 'Review the selected code.',
          system_prompt = 'COPILOT_REVIEW',
        },
        
        -- Bug fixes
        Fix = {
          prompt = 'There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.',
        },
        
        -- Code optimization
        Optimize = {
          prompt = 'Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.',
        },
        
        -- Documentation generation
        Docs = {
          prompt = 'Please add documentation comments to the selected code.',
        },
        
        -- Test generation
        Tests = {
          prompt = 'Please generate tests for my code.',
        },
        
        -- Commit message generation
        Commit = {
          prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
          context = 'git:staged',
        },
        
        -- Custom advanced prompts
        Refactor = {
          prompt = 'Please refactor the following code to improve its structure and readability. Explain the changes you made and why they improve the code.',
        },
        
        BestPractices = {
          prompt = 'Review this code for best practices and suggest improvements. Focus on code quality, maintainability, and adherence to language-specific conventions.',
        },
        
        Security = {
          prompt = 'Analyze this code for potential security vulnerabilities and suggest fixes. Consider common security issues like injection attacks, authentication, authorization, and data validation.',
        },
        
        Performance = {
          prompt = 'Analyze this code for performance issues and suggest optimizations. Consider algorithmic complexity, memory usage, and language-specific performance patterns.',
        },
        
        -- Context-aware prompts
        ImplementFeature = {
          prompt = 'Based on the selected code, implement the following feature: ',
          mapping = '<leader>cif',
          description = 'Implement a new feature based on existing code',
        },
        
        ExplainError = {
          prompt = 'Explain this error and provide a solution: ',
          mapping = '<leader>cee',
          description = 'Explain error and provide solution',
        },
      },
      
      -- Custom mappings for chat buffer
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        reset = {
          normal = '<C-l>',
          insert = '<C-l>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle_sticky = {
          normal = 'grr',
        },
        clear_stickies = {
          normal = 'grx',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        jump_to_diff = {
          normal = 'gj',
        },
        quickfix_answers = {
          normal = 'gqa',
        },
        quickfix_diffs = {
          normal = 'gqd',
        },
        yank_diff = {
          normal = 'gy',
          register = '"',
        },
        show_diff = {
          normal = 'gd',
          full_diff = false,
        },
        show_info = {
          normal = 'gi',
        },
        show_context = {
          normal = 'gc',
        },
        show_help = {
          normal = 'gh',
        },
      },
    })
    
    -- Global keymaps for CopilotChat
    -- Core commands
    vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "Toggle Copilot Chat" })
    vim.keymap.set("n", "<leader>co", function() chat.open() end, { desc = "Open Copilot Chat" })
    vim.keymap.set("n", "<leader>cx", function() chat.close() end, { desc = "Close Copilot Chat" })
    vim.keymap.set("n", "<leader>cr", function() chat.reset() end, { desc = "Reset Copilot Chat" })
    vim.keymap.set("n", "<leader>cs", function() chat.stop() end, { desc = "Stop Copilot Chat" })
    
    -- Prompt-based commands - these work with current selection
    vim.keymap.set({"n", "v"}, "<leader>cce", "<cmd>CopilotChatExplain<cr>", { desc = "Explain code" })
    vim.keymap.set({"n", "v"}, "<leader>ccr", "<cmd>CopilotChatReview<cr>", { desc = "Review code" })
    vim.keymap.set({"n", "v"}, "<leader>ccf", "<cmd>CopilotChatFix<cr>", { desc = "Fix code" })
    vim.keymap.set({"n", "v"}, "<leader>cco", "<cmd>CopilotChatOptimize<cr>", { desc = "Optimize code" })
    vim.keymap.set({"n", "v"}, "<leader>ccd", "<cmd>CopilotChatDocs<cr>", { desc = "Generate docs" })
    vim.keymap.set({"n", "v"}, "<leader>cct", "<cmd>CopilotChatTests<cr>", { desc = "Generate tests" })
    vim.keymap.set({"n", "v"}, "<leader>ccrf", "<cmd>CopilotChatRefactor<cr>", { desc = "Refactor code" })
    vim.keymap.set({"n", "v"}, "<leader>ccb", "<cmd>CopilotChatBestPractices<cr>", { desc = "Best practices" })
    vim.keymap.set({"n", "v"}, "<leader>ccs", "<cmd>CopilotChatSecurity<cr>", { desc = "Security review" })
    vim.keymap.set({"n", "v"}, "<leader>ccp", "<cmd>CopilotChatPerformance<cr>", { desc = "Performance review" })
    
    -- Git integration
    vim.keymap.set("n", "<leader>ccg", "<cmd>CopilotChatCommit<cr>", { desc = "Generate commit message" })
    
    -- Advanced features
    vim.keymap.set("n", "<leader>ccm", "<cmd>CopilotChatModels<cr>", { desc = "Select model" })
    vim.keymap.set("n", "<leader>cca", "<cmd>CopilotChatAgents<cr>", { desc = "Select agent" })
    vim.keymap.set("n", "<leader>ccp", "<cmd>CopilotChatPrompts<cr>", { desc = "Select prompt" })
    
    -- Chat history
    vim.keymap.set("n", "<leader>ccl", function()
      vim.ui.input({ prompt = "Load chat (name): " }, function(name)
        if name then
          chat.load(name)
        end
      end)
    end, { desc = "Load chat history" })
    
    vim.keymap.set("n", "<leader>ccS", function()
      vim.ui.input({ prompt = "Save chat (name): " }, function(name)
        if name then
          chat.save(name)
        end
      end)
    end, { desc = "Save chat history" })
    
    -- Custom prompts with input
    vim.keymap.set({"n", "v"}, "<leader>cci", function()
      vim.ui.input({ prompt = "Ask Copilot: " }, function(input)
        if input then
          chat.ask(input)
        end
      end)
    end, { desc = "Ask custom question" })
    
    -- Context-specific commands
    vim.keymap.set("n", "<leader>ccbf", function()
      chat.ask("Explain what this file does and its main purpose.", {
        selection = select.buffer,
      })
    end, { desc = "Explain buffer" })
    
    vim.keymap.set("n", "<leader>ccgd", function()
      chat.ask("Explain these git changes.", {
        context = "git",
      })
    end, { desc = "Explain git diff" })
    
    -- Line-specific command
    vim.keymap.set("n", "<leader>ccl", function()
      chat.ask("Explain this line of code in detail.", {
        selection = select.line,
      })
    end, { desc = "Explain current line" })
    
    -- Quick actions for selected text
    vim.keymap.set("v", "<leader>cq", function()
      chat.ask("Quick question about this code: " .. vim.fn.input("Question: "), {
        selection = select.visual,
      })
    end, { desc = "Quick question about selection" })
    
    -- Buffer auto-commands for chat window
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function()
        -- Set buffer-local options for better UX
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.cursorline = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.foldcolumn = "0"
      end,
    })
    
    -- Notification on chat completion
    vim.api.nvim_create_autocmd("User", {
      pattern = "CopilotChatComplete",
      callback = function()
        vim.notify("Copilot Chat response complete", vim.log.levels.INFO)
      end,
    })
  end,
}
