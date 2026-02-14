-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'

    telescope.setup {
      defaults = {
        winblend = 0,
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-l>'] = actions.select_default,
            ['<C-r>'] = actions.paste_register,
          },
          n = {
            ['q'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv', 'query.sql.go', '*_templ.go' },
          hidden = true,
        },
        
-- Replace your current buffers picker block with this
buffers = themes.get_dropdown {
  initial_mode = 'normal',
  sort_lastused = true,
  previewer = false,
  layout_config = { width = 0.8, height = 0.5 },
  entry_maker = function(entry)
    local devicons = require('nvim-web-devicons')
    local entry_display = require('telescope.pickers.entry_display')

    local displayer = entry_display.create {
      separator = " ",
      items = {
        { width = 2 },   -- Icon
        { width = 45 },  -- Path
        { width = 3 },   -- Modified [+]
        { width = 6 },   -- Errors
        { width = 6 },   -- Warnings
      },
    }

    local raw_path = entry.filename or entry.path or (entry.info and entry.info.name) or "unknown"
    local relative_path = vim.fn.fnamemodify(raw_path, ":.")
    local display_name = vim.fn.fnamemodify(raw_path, ":t")
    local icon, icon_col = devicons.get_icon(display_name, string.match(display_name, "%.([^.]+)$"), { default = true })

    -- Logic for Diagnostics
    local errors = 0
    local warnings = 0
    if vim.api.nvim_buf_is_valid(entry.bufnr) then
      errors = #vim.diagnostic.get(entry.bufnr, { severity = vim.diagnostic.severity.ERROR })
      warnings = #vim.diagnostic.get(entry.bufnr, { severity = vim.diagnostic.severity.WARN })
    end

    -- Check if buffer is modified
    local modified = vim.api.nvim_get_option_value('modified', { buf = entry.bufnr }) and "[+]" or ""

    return {
      value = entry,
      ordinal = relative_path,
      filename = raw_path,
      bufnr = entry.bufnr,
      display = function(ent)
        return displayer {
          { icon, icon_col },
          { relative_path, "TelescopeResultsComment" },
          { modified, "String" }, -- Greenish color for modified
          { errors > 0 and (" " .. errors) or "", "DiagnosticError" },
          { warnings > 0 and (" " .. warnings) or "", "DiagnosticWarn" },
        }
      end,
    }
  end,
  mappings = {
    i = { ["<C-d>"] = actions.delete_buffer },
    n = { ["d"] = actions.delete_buffer, ["l"] = actions.select_default },
  },
},     },
      live_grep = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
        additional_args = function(_)
          return { '--hidden' }
        end,
      },
      path_display = {
        filename_first = {
          reverse_directories = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },
      },
      git_files = {
        previewer = false,
      },
    }

    -- Enable extensions
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')

    -- KEYMAPS
    -- The requested buffer modal
    vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[B]uffers (Modal)' })
    
    -- Your existing mappings
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
    -- vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    -- vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Search [G]it [C]ommits' })
    -- vim.keymap.set('n', '<leader>gcf', builtin.git_bcommits, { desc = 'Search [G]it [C]ommits for current [F]ile' })
    -- vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Search [G]it [B]ranches' })
    -- vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Search [G]it [S]tatus (diff view)' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]resume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[ ] Search Files' })
   -- Keymap to show errors across the entire project/open buffers


vim.keymap.set('n', '<leader>se', function()
  require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown({
    bufnr = nil,              -- nil shows diagnostics for ALL buffers
    severity = "ERROR", -- Only show Errors (ignores warnings/hints)
    root_dir= true,
    layout_config = { width = 0.8, height = 0.6 },
  }))
end, { desc = '[S]earch [E]rrors' })

    vim.keymap.set('n', '<leader>sds', function()
      builtin.lsp_document_symbols {
        symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Property' },
      }
    end, { desc = '[S]each LSP document [S]ymbols' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
