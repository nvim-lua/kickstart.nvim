--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ========================================================================
-- MODULAR CONFIGURATION
-- ========================================================================
-- This init.lua has been split into modular pieces for better organization.
-- Each module is responsible for a specific aspect of the configuration:
--
--   lua/config/options.lua   - Vim options (set, opt)
--   lua/config/keymaps.lua   - Global keymaps
--   lua/config/autocmds.lua  - Global autocommands
--   lua/config/lazy.lua      - Plugin manager and all plugins
--
-- Language-specific configurations are in:
--   lua/custom/plugins/      - Custom plugins (Flutter, Python, etc.)
--   lua/kickstart/plugins/   - Kickstart default plugins
--
-- See ORGANIZATION.md for more details on the structure.
-- ========================================================================

-- Load core configuration modules
require 'config.options'  -- Vim options and settings
require 'config.keymaps'  -- Global keymaps
require 'config.autocmds' -- Global autocommands
require 'config.lazy'     -- Plugin manager and plugins

-- ========================================================================
-- LANGUAGE-SPECIFIC LSP SETUP (for lazy-loaded profiles)
-- ========================================================================
-- Python LSP - starts when opening .py files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  once = false,
  callback = function(args)
    -- Check if pyright is already attached
    local clients = vim.lsp.get_clients { bufnr = args.buf, name = 'pyright' }
    if #clients > 0 then
      return
    end

    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local root_dir = vim.fs.root(args.buf, {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
    })

    -- Find Python interpreter (prioritize virtual environments)
    local function find_python()
      if not root_dir then
        return nil
      end

      -- Check common venv locations relative to project root
      local venv_paths = {
        root_dir .. '/.venv/bin/python',
        root_dir .. '/venv/bin/python',
        root_dir .. '/.env/bin/python',
        root_dir .. '/env/bin/python',
      }

      for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end

      return nil
    end

    local python_path = find_python()

    vim.lsp.start {
      name = 'pyright',
      cmd = { vim.fn.stdpath 'data' .. '/mason/bin/pyright-langserver', '--stdio' },
      root_dir = root_dir or vim.fn.getcwd(),
      capabilities = capabilities,
      settings = {
        python = {
          pythonPath = python_path, -- Tell pyright which Python to use
          analysis = {
            typeCheckingMode = 'basic',
            autoImportCompletions = true,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
          },
        },
      },
    }
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
