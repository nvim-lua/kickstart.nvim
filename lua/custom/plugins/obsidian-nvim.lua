return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = 'main',
        path = '~/Documents/obsidian_git/Obsidian_vault/',
      },
    },
    daily_notes = {
      folder = 'Journals',
      date_format = '%Y%m%d',
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    local vault_path = vim.fn.expand '~/Documents/obsidian_git/Obsidian_vault/'

    -- Custom function to search by alias and filename
    local function search_by_alias()
      local pickers = require 'telescope.pickers'
      local finders = require 'telescope.finders'
      local conf = require('telescope.config').values
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      -- Collect all files with their aliases
      local entries = {}
      local scandir = require 'plenary.scandir'
      local files = scandir.scan_dir(vault_path, { hidden = false, depth = 10, add_dirs = false })

      for _, file in ipairs(files) do
        if file:match '%.md$' then
          local rel_path = file:gsub(vault_path, '')
          local filename = vim.fn.fnamemodify(file, ':t:r')

          -- Always add an entry for the filename
          table.insert(entries, {
            alias = nil,
            filename = filename,
            path = file,
            display = filename .. ' (' .. rel_path .. ')',
            ordinal = filename,
          })

          local f = io.open(file, 'r')
          if f then
            local content = f:read '*a'
            f:close()

            -- Parse YAML frontmatter
            local frontmatter = content:match '^%-%-%-\n(.-)\n%-%-%-'
            if frontmatter then
              -- Extract aliases (supports both list and inline formats)
              local aliases = {}

              -- Match "aliases: [alias1, alias2]" format
              local inline_aliases = frontmatter:match 'aliases:%s*%[(.-)%]'
              if inline_aliases then
                for alias in inline_aliases:gmatch '[^,]+' do
                  alias = alias:match '^%s*(.-)%s*$' -- trim
                  alias = alias:gsub('^"(.-)"$', '%1'):gsub("^'(.-)'$", '%1') -- remove quotes
                  if alias ~= '' then
                    table.insert(aliases, alias)
                  end
                end
              end

              -- Match YAML list format:
              -- aliases:
              --   - alias1
              --   - alias2
              local list_section = frontmatter:match 'aliases:%s*\n(.-)\n%w' or frontmatter:match 'aliases:%s*\n(.-)$'
              if list_section then
                for alias in list_section:gmatch '%s*%-%s*([^\n]+)' do
                  alias = alias:match '^%s*(.-)%s*$'
                  alias = alias:gsub('^"(.-)"$', '%1'):gsub("^'(.-)'$", '%1')
                  if alias ~= '' then
                    table.insert(aliases, alias)
                  end
                end
              end

              -- Add entries for each alias
              for _, alias in ipairs(aliases) do
                table.insert(entries, {
                  alias = alias,
                  filename = filename,
                  path = file,
                  display = alias .. ' -> ' .. rel_path,
                  ordinal = alias .. ' ' .. filename,
                })
              end
            end
          end
        end
      end

      pickers
        .new({}, {
          prompt_title = 'Search Obsidian (Alias & Filename)',
          finder = finders.new_table {
            results = entries,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.display,
                ordinal = entry.ordinal,
                path = entry.path,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          previewer = conf.file_previewer {},
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                vim.cmd('edit ' .. vim.fn.fnameescape(selection.path))
              end
            end)
            return true
          end,
        })
        :find()
    end

    -- Insert link to today's daily note
    local function insert_today_link()
      local date_link = os.date '%Y%m%d'
      local date_display = os.date '%Y/%m/%d'
      local link = '[[' .. date_link .. '|' .. date_display .. ']]'
      vim.api.nvim_put({ link }, 'c', true, true)
    end

    -- Set up keymaps
    vim.keymap.set('n', '<leader> ', search_by_alias, { desc = 'Search Obsidian (Alias & Filename)' })
    vim.keymap.set('n', '<leader>od', '<cmd>Obsidian today<cr>', { desc = '[O]bsidian [D]aily note (today)' })
    vim.keymap.set('n', '<leader>ot', insert_today_link, { desc = '[O]bsidian insert [T]oday link' })
  end,
}
