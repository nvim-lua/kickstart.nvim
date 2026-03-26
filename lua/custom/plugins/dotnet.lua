-- =============================================================================
-- .NET / C# Development Setup
-- =============================================================================
-- This file wires up everything needed for a productive .NET experience in
-- Neovim: Roslyn LSP, GitHub Copilot (via blink.cmp), DAP debugging with
-- netcoredbg, and Neotest for running xUnit/NUnit/MSTest tests.
--
-- PREREQUISITES (install once on your system):
--   - .NET SDK:  https://dotnet.microsoft.com/download
--   - Node.js > 20 (for Copilot): https://nodejs.org
--   - On first launch run:  :Copilot auth   (one-time GitHub login)
--   - Mason will auto-install: netcoredbg, csharpier
--   - roslyn.nvim downloads its own language server on first use
--
-- QUICK REFERENCE — KEY BINDINGS
-- (language-agnostic binds work everywhere; .NET-specific are noted)
-- =============================================================================
--
-- ── LSP NAVIGATION ────────────────────────────────────────────────────────────
--   grd          Go to Definition         (jump to where a symbol is defined)
--   grD          Go to Declaration        (e.g. interface declaration)
--   gri          Go to Implementation     (jump to concrete implementation)
--   grr          Find All References      (list all usages in Telescope)
--   grt          Go to Type Definition    (jump to the type of a variable)
--   gO           Document Symbols         (fuzzy search symbols in this file)
--   gW           Workspace Symbols        (fuzzy search symbols in whole project)
--   K            Hover Documentation      (show docs / type info under cursor)
--   grn          Rename Symbol            (rename across the whole project)
--   gra          Code Actions             (fix suggestions, extract method, etc.)
--   <leader>f    Format Buffer            (run csharpier on the current file)
--   <leader>th   Toggle Inlay Hints       (show/hide parameter name hints)
--   [d / ]d      Previous / Next Diagnostic
--   <leader>q    Diagnostic Quickfix List
--   <leader>sd   Search Diagnostics       (Telescope)
--
-- ── COMPLETION (blink.cmp) ────────────────────────────────────────────────────
--   <C-Space>    Open completion menu      (or open docs if menu is open)
--   <C-n> / <C-p>  Next / Previous item   (also <Up> / <Down>)
--   <C-y>        Accept completion         (auto-imports if LSP supports it)
--   <C-e>        Dismiss menu
--   <C-k>        Toggle signature help     (see function parameter hints)
--   <Tab>/<S-Tab>  Move through snippet expansions
--
-- ── GITHUB COPILOT ────────────────────────────────────────────────────────────
--   Copilot suggestions appear in the blink.cmp completion menu automatically.
--   They are ranked alongside LSP completions — just navigate with <C-n>/<C-p>.
--   :Copilot auth     Re-authenticate with GitHub (run once on first setup)
--   :Copilot status   Check if Copilot is active
--
-- ── DEBUGGING (nvim-dap + netcoredbg) ─────────────────────────────────────────
--   <leader>dc   Continue / Start debug session
--   <leader>db   Toggle Breakpoint         (set/unset on current line)
--   <leader>dB   Conditional Breakpoint    (prompt for a condition expression)
--   <leader>ds   Step Over                 (F10 equivalent)
--   <leader>di   Step Into                 (F11 equivalent)
--   <leader>do   Step Out                  (Shift-F11 equivalent)
--   <leader>dr   Open REPL                 (interactive debug console)
--   <leader>dl   Re-run Last Session       (repeat last debug config)
--   <leader>du   Toggle Debug UI           (show/hide the dap-ui panels)
--   <leader>de   Evaluate Expression       (hover eval under cursor)
--   <leader>dE   Evaluate (input prompt)   (type an expression to evaluate)
--
--   The debug UI opens automatically when a session starts and shows:
--     Left panel:  Scopes · Breakpoints · Call Stack · Watches
--     Bottom panel: REPL · Console output
--
-- ── TESTING (neotest + neotest-dotnet) ────────────────────────────────────────
--   <leader>nn   Run Nearest Test          (test method under cursor)
--   <leader>nf   Run File Tests            (all tests in current file)
--   <leader>na   Run All Tests             (entire project/solution)
--   <leader>ns   Toggle Test Summary       (tree view of all tests + status)
--   <leader>no   Show Test Output          (output of last test run)
--   <leader>np   Show Short Output         (condensed output panel)
--   <leader>nd   Debug Nearest Test        (run test under cursor with DAP)
--   <leader>nw   Watch Nearest Test        (re-run on file save)
--   <leader>nx   Stop Running Tests
--
-- =============================================================================

return {

  -- ===========================================================================
  -- 1. ROSLYN LSP  (seblj/roslyn.nvim)
  -- ===========================================================================
  -- The same Roslyn language server that powers Visual Studio and Rider.
  -- Downloads Microsoft.CodeAnalysis.LanguageServer automatically on first use.
  -- Provides: IntelliSense, go-to-definition, find-references, rename,
  --           code actions (extract method, add using, etc.), inlay hints,
  --           and full project/solution awareness.
  {
    'seblj/roslyn.nvim',
    ft = { 'cs', 'vb' },
    dependencies = {
      'mason-org/mason.nvim', -- ensures mason is loaded first
    },
    opts = {
      -- roslyn.nvim finds and downloads the language server into stdpath('data').
      -- Set exe to override with a custom path if you manage the server yourself.
      config = {
        -- Pass extra capabilities from blink.cmp so the LSP knows we support
        -- snippet completions, resolve, etc.
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          -- blink.cmp may not be loaded yet at spec parse time; we wrap in a
          -- function via on_attach / capabilities below instead.
          {}
        ),
      },
      -- In larger repos / monoliths this helps Roslyn search a bit wider for
      -- the correct solution or project root.
      broad_search = true,
      -- Allow target switching when multiple solutions exist in the repo.
      lock_target = false,
    },
    config = function(_, opts)
      -- Inject blink.cmp capabilities now that blink is guaranteed loaded.
      local ok, blink = pcall(require, 'blink.cmp')
      if ok then
        opts.config = opts.config or {}
        opts.config.capabilities = blink.get_lsp_capabilities(opts.config.capabilities)
      end

      require('roslyn').setup(opts)
    end,
  },

  -- ===========================================================================
  -- 2. GITHUB COPILOT  (zbirenbaum/copilot.lua + blink-cmp-copilot)
  -- ===========================================================================
  -- copilot.lua runs the Copilot LSP in the background.
  -- We disable the built-in ghost-text / panel UI and instead surface
  -- completions through blink.cmp so everything comes from one menu.
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      -- Disable copilot.lua's own UI — blink.cmp owns the completion menu.
      suggestion = { enabled = false },
      panel = { enabled = false },
      -- Explicitly enable C# (and a few other useful filetypes).
      filetypes = {
        cs = true,
        lua = true,
        python = true,
        javascript = true,
        typescript = true,
        -- Disable noisy filetypes.
        markdown = false,
        help = false,
        gitcommit = false,
      },
      -- Node.js must be > 20.
      copilot_node_command = 'node',
    },
  },

  -- blink-cmp-copilot bridges copilot.lua into blink.cmp as a source provider.
  -- Copilot completions appear in the menu with a  icon and "Copilot" label.
  {
    'giuxtaposition/blink-cmp-copilot',
    dependencies = { 'zbirenbaum/copilot.lua' },
    -- blink.cmp is already configured in init.lua; we patch its sources table
    -- here so we don't have to touch the existing config.
    specs = {
      {
        'saghen/blink.cmp',
        optional = true,
        opts = {
          sources = {
            default = { 'lsp', 'path', 'snippets', 'copilot' },
            providers = {
              copilot = {
                name = 'copilot',
                module = 'blink-cmp-copilot',
                -- Show Copilot items after LSP items in the menu.
                score_offset = -1,
                async = true,
                -- Give it a recognisable icon in the completion menu.
                transform_items = function(_, items)
                  for _, item in ipairs(items) do
                    item.kind_icon = ''
                    item.kind_name = 'Copilot'
                  end
                  return items
                end,
              },
            },
          },
        },
      },
    },
  },

  -- ===========================================================================
  -- 3. DEBUGGING  (nvim-dap + nvim-dap-ui + mason-nvim-dap)
  -- ===========================================================================
  -- netcoredbg is the open-source .NET debugger that understands the DAP
  -- protocol.  mason-nvim-dap installs it automatically.
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Automatic installer / bridge between mason and dap adapters.
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
          -- Let mason-nvim-dap install and configure netcoredbg.
          ensure_installed = { 'netcoredbg' },
          automatic_installation = true,
          handlers = {}, -- use default handlers for installed adapters
        },
      },

      -- A full debug UI: scopes, locals, call stack, breakpoints, REPL.
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        config = function()
          local dap = require 'dap'
          local dapui = require 'dapui'

          dapui.setup {
            -- Layout: left sidebar + bottom panel — mirrors a typical IDE layout.
            layouts = {
              {
                -- Left sidebar: variables, call stack, breakpoints, watches.
                position = 'left',
                size = 40,
                elements = {
                  { id = 'scopes', size = 0.35 },
                  { id = 'stacks', size = 0.35 },
                  { id = 'breakpoints', size = 0.15 },
                  { id = 'watches', size = 0.15 },
                },
              },
              {
                -- Bottom tray: REPL for live evaluation + program console output.
                position = 'bottom',
                size = 12,
                elements = {
                  { id = 'repl', size = 0.5 },
                  { id = 'console', size = 0.5 },
                },
              },
            },
          }

          -- Auto-open the UI when a debug session starts.
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          -- Auto-close the UI when the session ends or terminates.
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end
        end,
      },

      -- Virtual text shows variable values inline while stepping through code.
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
          -- Show the value of the variable at the current scope inline.
          display_callback = function(variable, _, _, _, options)
            if #variable.value > 60 then
              return ' ' .. string.sub(variable.value, 1, 57) .. '...'
            end
            return ' ' .. variable.value
          end,
        },
      },
    },

    config = function()
      local dap = require 'dap'

      -- ── Adapter ─────────────────────────────────────────────────────────────
      -- mason-nvim-dap installs netcoredbg into mason's bin directory.
      -- We resolve the path at runtime so it works on any machine.
      local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
      local netcoredbg_cmd = mason_bin .. '/netcoredbg'
      -- On Windows mason wraps executables in .cmd files.
      if vim.fn.has 'win32' == 1 then
        netcoredbg_cmd = mason_bin .. '/netcoredbg.cmd'
      end

      dap.adapters.coreclr = {
        type = 'executable',
        command = netcoredbg_cmd,
        args = { '--interpreter=vscode' },
      }

      -- ── Helper: prompt for / remember DLL path ───────────────────────────
      -- On first launch you'll be asked for the path to the compiled DLL.
      -- The answer is cached for the rest of the session; you're only re-asked
      -- if you confirm you want to change it.
      local function get_dll_path()
        if vim.g.dotnet_last_dll_path == nil then
          vim.g.dotnet_last_dll_path = vim.fn.input(
            'Path to DLL: ',
            vim.fn.getcwd() .. '/bin/Debug/',
            'file'
          )
        else
          local change = vim.fn.confirm(
            'Reuse last DLL?\n' .. vim.g.dotnet_last_dll_path,
            '&Yes\n&No',
            1
          )
          if change == 2 then
            vim.g.dotnet_last_dll_path = vim.fn.input(
              'Path to DLL: ',
              vim.g.dotnet_last_dll_path,
              'file'
            )
          end
        end
        return vim.g.dotnet_last_dll_path
      end

      -- ── Helper: optional pre-build ───────────────────────────────────────
      local function maybe_build()
        local build = vim.fn.confirm('Build project first?', '&Yes\n&No', 2)
        if build == 1 then
          local proj = vim.fn.input(
            'Path to .csproj/.sln: ',
            vim.g.dotnet_last_proj_path or (vim.fn.getcwd() .. '/'),
            'file'
          )
          vim.g.dotnet_last_proj_path = proj
          vim.notify('Building ' .. proj .. ' …', vim.log.levels.INFO)
          local result = os.execute('dotnet build -c Debug "' .. proj .. '" > /dev/null 2>&1')
          if result == 0 then
            vim.notify('Build succeeded', vim.log.levels.INFO)
          else
            vim.notify('Build FAILED — check :messages', vim.log.levels.ERROR)
          end
        end
      end

      -- ── Launch configurations ────────────────────────────────────────────
      -- Shared across cs and fsharp.
      local dotnet_launch = {
        {
          type = 'coreclr',
          name = 'Launch .NET (netcoredbg)',
          request = 'launch',
          program = function()
            maybe_build()
            return get_dll_path()
          end,
        },
        {
          -- Attach to a running process (e.g. an already-running web server).
          type = 'coreclr',
          name = 'Attach to process',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
      }

      dap.configurations.cs = dotnet_launch
      dap.configurations.fsharp = dotnet_launch

      -- ── Keybinds ─────────────────────────────────────────────────────────
      -- See the header comment at the top of this file for full descriptions.
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { desc = 'Debug: ' .. desc })
      end

      map('<leader>dc', dap.continue, '[C]ontinue / Start')
      map('<leader>db', dap.toggle_breakpoint, 'Toggle [B]reakpoint')
      map('<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, 'Conditional [B]reakpoint')
      map('<leader>ds', dap.step_over, '[S]tep Over')
      map('<leader>di', dap.step_into, 'Step [I]nto')
      map('<leader>do', dap.step_out, 'Step [O]ut')
      map('<leader>dr', dap.repl.open, 'Open [R]EPL')
      map('<leader>dl', dap.run_last, 'Run [L]ast')
      map('<leader>du', function() require('dapui').toggle() end, 'Toggle [U]I')
      map('<leader>de', function() require('dapui').eval() end, '[E]val under cursor')
      map('<leader>dE', function()
        require('dapui').eval(vim.fn.input 'Expression: ')
      end, '[E]val expression')

      -- Register the <leader>d group name with which-key (if loaded).
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add { { '<leader>d', group = '[D]ebug' } }
      end
    end,
  },

  -- ===========================================================================
  -- 4. TESTING  (nvim-neotest + neotest-dotnet)
  -- ===========================================================================
  -- neotest-dotnet discovers xUnit, NUnit, and MSTest tests automatically by
  -- scanning for [Fact], [Theory], [Test], [TestCase], etc. attributes.
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim', -- required by neotest
      'nvim-treesitter/nvim-treesitter',
      -- .NET adapter — supports xUnit, NUnit, MSTest.
      'Issafalcon/neotest-dotnet',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require('neotest-dotnet') {
            -- dap integration: <leader>nd will attach the debugger to the test.
            dap = { justMyCode = false },
            -- Discover tests using the dotnet CLI runner.
            -- Set to 'omnisharp' if you prefer the OmniSharp test runner.
            dotnet_additional_args = {},
          },
        },
        -- Show pass/fail icons in the gutter next to each test.
        status = { enabled = true, signs = true, virtual_text = false },
        -- Open the output panel automatically for short failures.
        output = { enabled = true, open_on_run = 'short' },
        -- Use a bottom split for the output panel.
        output_panel = {
          enabled = true,
          open = 'botright split | resize 15',
        },
      }

      -- ── Keybinds ─────────────────────────────────────────────────────────
      -- See the header comment at the top of this file for full descriptions.
      local nt = require 'neotest'
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { desc = 'Test: ' .. desc })
      end

      map('<leader>nn', function() nt.run.run() end, 'Run [N]earest test')
      map('<leader>nf', function() nt.run.run(vim.fn.expand '%') end, 'Run [F]ile tests')
      map('<leader>na', function() nt.run.run(vim.fn.getcwd()) end, 'Run [A]ll tests')
      map('<leader>ns', function() nt.summary.toggle() end, 'Toggle [S]ummary panel')
      map('<leader>no', function() nt.output.open { enter = true } end, 'Show [O]utput')
      map('<leader>np', function() nt.output_panel.toggle() end, 'Toggle output [P]anel')
      map('<leader>nd', function() nt.run.run { strategy = 'dap' } end, '[D]ebug nearest test')
      map('<leader>nw', function() nt.watch.toggle(vim.fn.expand '%') end, '[W]atch file tests')
      map('<leader>nx', function() nt.run.stop() end, 'Stop running tests')

      -- Register the <leader>n group name with which-key (if loaded).
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add { { '<leader>n', group = '[N]eotest' } }
      end
    end,
  },

  -- ===========================================================================
  -- 5. CSHARPIER (formatter, installed via Mason)
  -- ===========================================================================
  -- csharpier is the opinionated C# formatter (like gofmt/prettier for C#).
  -- It is installed by mason-tool-installer below and wired into conform.nvim.
  {
    -- Re-use mason-tool-installer (already set up in init.lua) to ensure
    -- csharpier is installed.  We declare it as a separate spec here so this
    -- file is self-contained; lazy.nvim merges duplicate plugin specs.
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'csharpier', 'roslyn' })
    end,
  },
  {
    -- Patch conform.nvim to format C# files with csharpier.
    -- This merges cleanly with the existing conform setup in init.lua.
    'stevearc/conform.nvim',
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.cs = { 'csharpier' }
    end,
  },
}
