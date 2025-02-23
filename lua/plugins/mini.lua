return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- Session management
    local session = require('mini.sessions')
    
    -- Function to safely restore LSP state
    local function safe_restore_lsp()
      -- Disable semantic tokens temporarily during session load
      local semantic_tokens = {}
      for _, client in pairs(vim.lsp.get_active_clients()) do
        semantic_tokens[client.id] = client.server_capabilities.semanticTokensProvider
        client.server_capabilities.semanticTokensProvider = nil
      end

      -- Return a function to restore semantic tokens
      return function()
        for id, tokens in pairs(semantic_tokens) do
          local client = vim.lsp.get_client_by_id(id)
          if client then
            client.server_capabilities.semanticTokensProvider = tokens
          end
        end
      end
    end

    -- Get session name based on current directory
    local function get_session_name()
      local cwd = vim.fn.getcwd()
      -- Replace path separators and spaces with underscores
      local name = string.gsub(cwd, '[/\\%s]', '_')
      return name
    end

    -- Clean up buffers before saving session
    local function pre_save()
      -- Store current buffers
      local bufs = vim.api.nvim_list_bufs()
      
      -- Close special buffers that we don't want to save
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) then
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
          if buftype ~= '' or filetype == 'TelescopePrompt' or filetype == 'neo-tree' then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
    end

    -- Clean up after loading session
    local function post_load()
      -- Close any empty buffers that might have been created
      local bufs = vim.api.nvim_list_bufs()
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) then
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
          local modified = vim.api.nvim_buf_get_option(buf, 'modified')
          local name = vim.api.nvim_buf_get_name(buf)
          
          if not modified and (name == '' or buftype ~= '' or filetype == 'TelescopePrompt' or filetype == 'neo-tree') then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
    end

    -- Create session functions for use in keymaps
    _G.MiniSession = {
      save = function()
        local name = get_session_name()
        local ok, err = pcall(function() session.write(name) end)
        if ok then
          vim.notify(string.format('Session: Successfully saved "%s"', name),
            vim.log.levels.INFO)
        else
          vim.notify(string.format('Session: Failed to save "%s": %s', name, err),
            vim.log.levels.ERROR)
        end
      end,

      load = function()
        local name = get_session_name()
        local ok, err = pcall(function() session.read(name) end)
        if ok then
          vim.notify(string.format('Session: Successfully loaded "%s"', name),
            vim.log.levels.INFO)
        else
          vim.notify(string.format('Session: Failed to load "%s": %s', name, err),
            vim.log.levels.ERROR)
        end
      end,

      delete = function()
        local name = get_session_name()
        local ok, err = pcall(function() session.delete(name) end)
        if ok then
          vim.notify(string.format('Session: Successfully deleted "%s"', name),
            vim.log.levels.INFO)
        else
          vim.notify(string.format('Session: Failed to delete "%s": %s', name, err),
            vim.log.levels.ERROR)
        end
      end
    }

    -- Create session directory
    local session_dir = vim.fn.stdpath('data') .. '/sessions'
    if vim.fn.isdirectory(session_dir) == 0 then
      vim.fn.mkdir(session_dir, 'p')
    end

    session.setup({
      -- Directory to store session files
      directory = session_dir,
      -- File to use for current session
      file = get_session_name(),
      -- Whether to force write session file on each write operation
      force_write = true,
      -- Hook functions for actions
      hooks = {
        -- Before loading a session
        pre_load = function()
          -- Clean up buffers safely
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
            -- Don't close special buffers
            if ft ~= 'NvimTree' and ft ~= 'neo-tree' and ft ~= 'TelescopePrompt' then
              pcall(vim.api.nvim_buf_delete, buf, { force = false })
            end
          end
          return safe_restore_lsp()
        end,
        -- After loading a session
        post_load = function()
          post_load()
          -- Restore LSP semantic tokens after a short delay
          vim.defer_fn(function()
            if vim.v.vim_did_enter == 1 then
              for _, client in pairs(vim.lsp.get_active_clients()) do
                if client.server_capabilities.semanticTokensProvider then
                  vim.lsp.semantic_tokens.force_refresh(client.id)
                end
              end
            end
          end, 1000)
          vim.notify('Session loaded!', vim.log.levels.INFO)
        end,
        -- Before saving a session
        pre_save = function()
          vim.notify('Saving session...', vim.log.levels.INFO)
          pre_save()
        end,
        -- After saving a session
        post_save = nil,
      },
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,
      -- Whether to write current session before quitting Neovim
      autowrite = false, -- We'll handle this ourselves
      -- Whether to disable showing non-error feedback
      verbose = {
        read = false,  -- We'll handle our own notifications
        write = false,
        delete = false,
      },
    })

    -- Update session name when directory changes
    vim.api.nvim_create_autocmd('DirChanged', {
      callback = function()
        session.setup({ file = get_session_name() })
      end,
    })

    -- Auto-save session when leaving Neovim
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        -- Only save if we have buffers
        if #vim.fn.getbufinfo({buflisted = 1}) > 0 then
          _G.MiniSession.save()
        end
      end,
    })
  end,
}
