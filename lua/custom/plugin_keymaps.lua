--[[
  Plugin-specific keymaps configuration
  
  This file contains all the plugin-specific keybindings,
  organized by plugin for better readability and maintenance.
]]

local M = {}

-- Initialize plugin keymaps
function M.setup()
  -- Ensure vim is available in this scope
  local vim = vim or _G.vim or require('vim')
  
  -- Helper function for setting keymaps with proper labels
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    opts.silent = opts.silent == nil and true or opts.silent
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  
  -- Check if which-key is available  
  local which_key_ok, wk = pcall(require, "which-key")
  if not which_key_ok then
    vim.notify("Which-key not found, keybindings will be set without groups", vim.log.levels.WARN)
  end
  
  --------------------------------------------------
  -- TELESCOPE
  --------------------------------------------------
  local telescope_builtin_ok, builtin = pcall(require, "telescope.builtin")
  if telescope_builtin_ok then
    if which_key_ok then
      wk.add({
        { "<leader>f", group = "Find/Files" },
        { "<leader>ff", function() builtin.find_files() end, desc = "Find files" },
        { "<leader>fg", function() builtin.live_grep() end, desc = "Live grep" },
        { "<leader>fb", function() builtin.buffers() end, desc = "Find buffers" },
        { "<leader>fh", function() builtin.help_tags() end, desc = "Help tags" },
        { "<leader>fr", function() builtin.oldfiles() end, desc = "Recent files" },
        { "<leader>fc", function() builtin.grep_string() end, desc = "Grep current string" },
        { "<leader>fk", function() builtin.keymaps() end, desc = "Find keymaps" },
        { "<leader>fd", function() builtin.diagnostics() end, desc = "Search diagnostics" },
        { "<leader>fw", function() builtin.current_buffer_fuzzy_find() end, desc = "Search current buffer" },
      })
      
      wk.add({
        { "<leader>fg", group = "Git Search" },
        { "<leader>fgc", function() builtin.git_commits() end, desc = "Git commits" },
        { "<leader>fgb", function() builtin.git_branches() end, desc = "Git branches" },
        { "<leader>fgs", function() builtin.git_status() end, desc = "Git status" },
        { "<leader>fgt", function() builtin.git_stash() end, desc = "Git stashes" },
      })
      
      wk.add({
        { "<leader><leader>", function() builtin.buffers() end, desc = "Find buffers (Telescope)" },
      })
    else
      map("n", "<leader>ff", function() builtin.find_files() end, { desc = "Find files" })
      map("n", "<leader>fg", function() builtin.live_grep() end, { desc = "Live grep" })
      map("n", "<leader>fb", function() builtin.buffers() end, { desc = "Find buffers" })
      map("n", "<leader>fh", function() builtin.help_tags() end, { desc = "Help tags" })
      map("n", "<leader>fr", function() builtin.oldfiles() end, { desc = "Recent files" })
      map("n", "<leader>fc", function() builtin.grep_string() end, { desc = "Grep current string" })
      map("n", "<leader>fk", function() builtin.keymaps() end, { desc = "Find keymaps" })
      map("n", "<leader>fd", function() builtin.diagnostics() end, { desc = "Search diagnostics" })
      map("n", "<leader>fw", function() builtin.current_buffer_fuzzy_find() end, { desc = "Search current buffer" })
      map("n", "<leader>fgc", function() builtin.git_commits() end, { desc = "Git commits" })
      map("n", "<leader>fgb", function() builtin.git_branches() end, { desc = "Git branches" })
      map("n", "<leader>fgs", function() builtin.git_status() end, { desc = "Git status" })
      map("n", "<leader>fgt", function() builtin.git_stash() end, { desc = "Git stashes" })
      map("n", "<leader><leader>", function() builtin.buffers() end, { desc = "Find buffers (Telescope)" })
    end
  end

  --------------------------------------------------
  -- BUFFERLINE
  --------------------------------------------------
  local bufferline_commands_ok = pcall(require, 'bufferline')
  if bufferline_commands_ok then
    if which_key_ok then
      wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
        { "<leader>bc", "<cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
        { "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
        { "<leader>bl", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        { "<leader>bH", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
        { "<leader>bL", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
        { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
        { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
        { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
        { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer 4" },
        { "<leader>b5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer 5" },
        { "<leader>b6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Buffer 6" },
        { "<leader>b7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Buffer 7" },
        { "<leader>b8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Buffer 8" },
        { "<leader>b9", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Buffer 9" },
      })
      
      local alt_buffer_items = {}
      for i = 1, 9 do
        table.insert(alt_buffer_items, { 
          string.format("<A-%d>", i), 
          string.format("<cmd>BufferLineGoToBuffer %d<CR>", i), 
          desc = string.format("Buffer %d", i) 
        })
      end
      if #alt_buffer_items > 0 then
        wk.add(alt_buffer_items)
      end
    else
      map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
      map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
      map("n", "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      map("n", "<leader>bl", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      map("n", "<leader>bH", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
      map("n", "<leader>bL", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
      for i = 1, 9 do
        map("n", string.format("<leader>b%d", i), string.format("<cmd>BufferLineGoToBuffer %d<CR>", i), { desc = string.format("Buffer %d", i) })
        map("n", string.format("<A-%d>", i), string.format("<cmd>BufferLineGoToBuffer %d<CR>", i), { desc = string.format("Buffer %d", i) })
      end
    end
  end

  --------------------------------------------------
  -- HARPOON
  --------------------------------------------------
  local harpoon_ok, harpoon = pcall(require, "harpoon")
  if harpoon_ok then
    if which_key_ok then
      local harpoon_items = {
        { "<leader>h", group = "Harpoon" },
        { "<leader>ha", function() harpoon:list():add() end, desc = "Add file" },
        { "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle menu" },
      }
      for i = 1, 9 do
        table.insert(harpoon_items, { 
          string.format("<leader>h%d", i), 
          function() harpoon:list():select(i) end, 
          desc = string.format("Jump to file %d", i) 
        })
      end
      wk.add(harpoon_items)
      
      wk.add({
        { "<C-n>", function() harpoon:list():next() end, desc = "Harpoon next file" },
        { "<C-p>", function() harpoon:list():prev() end, desc = "Harpoon previous file" },
      })
    else
      map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file" })
      map("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle menu" })
      for i = 1, 9 do
        map("n", string.format("<leader>h%d", i), function() harpoon:list():select(i) end, { desc = string.format("Jump to file %d", i) })
      end
      map("n", "<C-n>", function() harpoon:list():next() end, { desc = "Harpoon next file" })
      map("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Harpoon previous file" })
    end
  end

  --------------------------------------------------
  -- GIT (LAZYGIT)
  --------------------------------------------------
  local lazygit_commands_ok = pcall(require, 'lazygit')
  if lazygit_commands_ok then
    if which_key_ok then
      wk.add({
        { "<leader>g", group = "Git" },
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
        { "<leader>gc", "<cmd>LazyGitConfig<CR>", desc = "LazyGit Config" },
        { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit Current File" },
        { "<leader>gb", "<cmd>LazyGitFilter<CR>", desc = "LazyGit Filter" },
        { "<leader>gB", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "LazyGit Filter Current File" },
      })
    else
      map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })
      map('n', '<leader>gc', '<cmd>LazyGitConfig<CR>', { desc = 'LazyGit Config' })
      map('n', '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', { desc = 'LazyGit Current File' })
      map('n', '<leader>gb', '<cmd>LazyGitFilter<CR>', { desc = 'LazyGit Filter' })
      map('n', '<leader>gB', '<cmd>LazyGitFilterCurrentFile<CR>', { desc = 'LazyGit Filter Current File' })
    end
  end

  --------------------------------------------------
  -- COMMENTING
  --------------------------------------------------
  -- Comment.nvim and other commenting tools are already mapped through their setup

  --------------------------------------------------
  -- COPILOT CHAT
  --------------------------------------------------
  local copilot_chat_ok = pcall(require, 'CopilotChat')
  if copilot_chat_ok then
    if which_key_ok then
      -- Normal mode commands
      wk.add({
        { "<leader>c", group = "Copilot" },
        { "<leader>cc", "<cmd>CopilotChat<CR>", desc = "Open Chat" },
        { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain Code" },
        { "<leader>cf", "<cmd>CopilotChatFixCode<CR>", desc = "Fix Code" },
        { "<leader>co", "<cmd>CopilotChatOptimize<CR>", desc = "Optimize Code" },
        { "<leader>cd", "<cmd>CopilotChatDocumentation<CR>", desc = "Generate Documentation" },
        { "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate Tests" },
        { "<leader>cb", "<cmd>CopilotChatBestPractices<CR>", desc = "Check Best Practices" },
        { "<leader>cr", "<cmd>CopilotChatRefactor<CR>", desc = "Refactor Code" },
        { "<leader>cs", "<cmd>CopilotChatSummarize<CR>", desc = "Summarize Code" },
        { "<leader>ch", "<cmd>CopilotChatHelp<CR>", desc = "Copilot Chat Help" },
      })

      -- Visual mode commands
      wk.add({
        { "<leader>c", group = "Copilot", mode = "v" },
        { "<leader>ce", ":CopilotChatExplain<CR>", desc = "Explain Selected Code", mode = "v" },
        { "<leader>cf", ":CopilotChatFixCode<CR>", desc = "Fix Selected Code", mode = "v" },
        { "<leader>co", ":CopilotChatOptimize<CR>", desc = "Optimize Selected Code", mode = "v" },
        { "<leader>cd", ":CopilotChatDocumentation<CR>", desc = "Document Selected Code", mode = "v" },
        { "<leader>ct", ":CopilotChatTests<CR>", desc = "Generate Tests for Selection", mode = "v" },
        { "<leader>cr", ":CopilotChatRefactor<CR>", desc = "Refactor Selected Code", mode = "v" },
        { "<leader>cs", ":CopilotChatSummarize<CR>", desc = "Summarize Selected Code", mode = "v" },
      })
    else
      map("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open Chat" })
      map("n", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Explain Code" })
      map("n", "<leader>cf", "<cmd>CopilotChatFixCode<CR>", { desc = "Fix Code" })
      map("n", "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "Optimize Code" })
      map("n", "<leader>cd", "<cmd>CopilotChatDocumentation<CR>", { desc = "Generate Documentation" })
      map("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate Tests" })
      map("n", "<leader>cb", "<cmd>CopilotChatBestPractices<CR>", { desc = "Check Best Practices" })
      map("n", "<leader>cr", "<cmd>CopilotChatRefactor<CR>", { desc = "Refactor Code" })
      map("n", "<leader>cs", "<cmd>CopilotChatSummarize<CR>", { desc = "Summarize Code" })
      map("n", "<leader>ch", "<cmd>CopilotChatHelp<CR>", { desc = "Copilot Chat Help" })

      map("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain Selected Code" })
      map("v", "<leader>cf", ":CopilotChatFixCode<CR>", { desc = "Fix Selected Code" })
      map("v", "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Optimize Selected Code" })
      map("v", "<leader>cd", ":CopilotChatDocumentation<CR>", { desc = "Document Selected Code" })
      map("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Generate Tests for Selection" })
      map("v", "<leader>cr", ":CopilotChatRefactor<CR>", { desc = "Refactor Selected Code" })
      map("v", "<leader>cs", ":CopilotChatSummarize<CR>", { desc = "Summarize Selected Code" })
    end
  end

  --------------------------------------------------
  -- LEETCODE
  --------------------------------------------------
  local leetcode_ok = pcall(require, 'leetcode')
  if leetcode_ok then
    if which_key_ok then
      wk.add({
        { "<leader>l", group = "LeetCode" },
        { "<leader>ll", "<cmd>Leet<CR>", desc = "Open LeetCode" },
        { "<leader>ld", "<cmd>Leet daily<CR>", desc = "LeetCode daily challenge" },
        { "<leader>lr", "<cmd>Leet random<CR>", desc = "LeetCode random problem" },
        { "<leader>ls", "<cmd>Leet submit<CR>", desc = "Submit LeetCode solution" },
        { "<leader>la", "<cmd>Leet tabs<CR>", desc = "Switch tab" },
      })
    else
      map('n', '<leader>ll', '<cmd>Leet<CR>', { desc = 'Open LeetCode' })
      map('n', '<leader>ld', '<cmd>Leet daily<CR>', { desc = 'LeetCode daily challenge' })
      map('n', '<leader>lr', '<cmd>Leet random<CR>', { desc = 'LeetCode random problem' })
      map('n', '<leader>ls', '<cmd>Leet submit<CR>', { desc = 'Submit LeetCode solution' })
      map('n', '<leader>la', '<cmd>Leet tabs<CR>', { desc = 'Switch tab' })
    end
  end

  return M
end

return M
