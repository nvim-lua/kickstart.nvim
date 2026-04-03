return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = {
    'nvim-mini/mini.nvim', -- for mini.icons
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local fl = require 'fzf-lua'
    fl.setup {
      lsp = {
        symbols = {
          symbol_icons = Glyphs.kinds,
        },
      },
    }

    -- fuzzy-find specific
    vim.keymap.set('n', '<leader>fl', fl.blines, { desc = 'Find line - current buf' })
    vim.keymap.set('n', '<leader>fL', fl.lines, { desc = 'Find line - open buffers' })
    vim.keymap.set('n', '<leader>ff', fl.files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>o', fl.buffers, { desc = '[O]pen buffers' })
    vim.keymap.set('n', '<leader>fR', fl.history, { desc = 'Recent files & buffers' })
    vim.keymap.set('n', '<leader>fr', fl.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>ft', fl.treesitter, { desc = 'Treesiter objects' })
    vim.keymap.set('n', '<leader>fn', function()
      fl.files { cwd = '~/.config/nvim/' }
    end, { desc = 'Neovim config files' })
    vim.keymap.set('n', '<leader>fN', function()
      fl.files { cwd = '~/.local/share/nvim/lazy/' }
    end, { desc = 'Neovim plugins src' })

    -- grep specific
    vim.keymap.set('n', '<leader>gb', fl.grep_curbuf, { desc = 'Grep current buffer' })
    vim.keymap.set('n', '<leader>gG', fl.grep_project, { desc = 'Grep project' })
    vim.keymap.set('n', '<leader>gg', fl.live_grep, { desc = 'Grep a pattern' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gv', fl.grep_visual, { desc = 'Grep with visual selection' })
    vim.keymap.set('n', '<leader>gw', fl.grep_cword, { desc = 'Grep word under cursor' })
    vim.keymap.set('n', '<leader>gW', fl.grep_cWORD, { desc = 'Grep WORD under cursor' })
    vim.keymap.set('n', '<leader>g.', function()
      fl.grep { resume = true }
    end, { desc = 'Resume last grep' })
    vim.keymap.set('n', '<leader>gN', function()
      fl.live_grep { cwd = '~/.local/share/nvim/lazy/' }
    end, { desc = 'Grep Neovim plugins src' })

    -- Git specific
    vim.keymap.set('n', '<leader>GC', fl.git_bcommits, { desc = 'Git: commits - current buf' })
    vim.keymap.set('n', '<leader>GS', fl.git_stash, { desc = 'Git: stash' })
    vim.keymap.set('n', '<leader>Gb', fl.git_branches, { desc = 'Git: branches' })
    vim.keymap.set('n', '<leader>Gc', fl.git_commits, { desc = 'Git: commits' })
    vim.keymap.set('n', '<leader>Gd', fl.git_diff, { desc = 'Git: diff' })
    vim.keymap.set('n', '<leader>Gf', fl.git_files, { desc = 'Git: files' })
    vim.keymap.set('n', '<leader>Gh', fl.git_hunks, { desc = 'Git: hunks' })
    vim.keymap.set('n', '<leader>Gs', fl.git_status, { desc = 'Git: status' })
    vim.keymap.set('n', '<leader>Gw', fl.git_worktrees, { desc = 'Git: worktrees' })

    -- LSP specific
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('fzflua-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf

        -- `gr` keymap style
        vim.keymap.set({ 'n', 'v' }, 'gra', fl.lsp_code_actions, { buffer = buf, desc = 'LSP: code actions' })
        vim.keymap.set({ 'n', 'v' }, 'grD', fl.lsp_declarations, { buffer = buf, desc = 'LSP: declaration' })
        vim.keymap.set({ 'n', 'v' }, 'grd', fl.lsp_definitions, { buffer = buf, desc = 'LSP: definition' })
        vim.keymap.set({ 'n', 'v' }, 'gri', fl.lsp_implementations, { buffer = buf, desc = 'LSP: implementations' })
        vim.keymap.set({ 'n', 'v' }, 'grI', fl.lsp_incoming_calls, { buffer = buf, desc = 'LSP: incoming calls' })
        vim.keymap.set({ 'n', 'v' }, 'grO', fl.lsp_outgoing_calls, { buffer = buf, desc = 'LSP: outgoing calls' })
        vim.keymap.set({ 'n', 'v' }, 'grr', fl.lsp_references, { buffer = buf, desc = 'LSP: references' })
        vim.keymap.set('n', 'grs', fl.lsp_document_symbols, { buffer = buf, desc = 'LSP: symbols - current buf' })
        vim.keymap.set('n', 'grw', fl.lsp_workspace_symbols, { buffer = buf, desc = 'LSP: symbols - workspace' })
        vim.keymap.set({ 'n', 'v' }, 'grt', fl.lsp_typedefs, { buffer = buf, desc = 'LSP: type definition' })

        -- my style
        vim.keymap.set({ 'n', 'v' }, '<leader>la', fl.lsp_code_actions, { buffer = buf, desc = 'LSP: code actions' })
        vim.keymap.set({ 'n', 'v' }, '<leader>lD', fl.lsp_declarations, { buffer = buf, desc = 'LSP: declaration' })
        vim.keymap.set({ 'n', 'v' }, '<leader>ld', fl.lsp_definitions, { buffer = buf, desc = 'LSP: definition' })
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>li',
          fl.lsp_implementations,
          { buffer = buf, desc = 'LSP: implementations' }
        )
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>lI',
          fl.lsp_incoming_calls,
          { buffer = buf, desc = 'LSP: incoming calls' }
        )
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>lO',
          fl.lsp_outgoing_calls,
          { buffer = buf, desc = 'LSP: outgoing calls' }
        )
        vim.keymap.set({ 'n', 'v' }, '<leader>lr', fl.lsp_references, { buffer = buf, desc = 'LSP: references' })
        vim.keymap.set(
          'n',
          '<leader>ls',
          fl.lsp_document_symbols,
          { buffer = buf, desc = 'LSP: symbols - current buf' }
        )
        vim.keymap.set('n', '<leader>lw', fl.lsp_workspace_symbols, { buffer = buf, desc = 'LSP: symbols - workspace' })
        vim.keymap.set({ 'n', 'v' }, '<leader>lt', fl.lsp_typedefs, { buffer = buf, desc = 'LSP: type definition' })
      end,
    })

    -- Diagnostic specific
    vim.keymap.set('n', '<leader>dd', fl.diagnostics_document, { desc = 'List diagnostics - current buf' })
    vim.keymap.set('n', '<leader>dw', fl.diagnostics_workspace, { desc = 'List diagnostics - workspace' })
    vim.keymap.set('n', '<leader>dz', fl.spellcheck, { desc = 'Spelling mistakes' })

    -- misc specific
    vim.keymap.set('n', "<leader>f'", fl.marks, { desc = 'Marks' })
    vim.keymap.set('n', '<leader>f:', fl.command_history, { desc = 'Command history' })
    vim.keymap.set('n', '<leader>f"', fl.registers, { desc = 'Registers' })
    vim.keymap.set('n', '<leader>f/', fl.search_history, { desc = 'Search history' })
    vim.keymap.set('n', '<leader>f;', fl.jumps, { desc = 'Jump list' })
    vim.keymap.set('n', '<leader>f.', fl.resume, { desc = 'Resume last command/query' }) -- conflict
    vim.keymap.set('n', '<leader>fh', fl.helptags, { desc = 'Help-Pages' })
    vim.keymap.set('n', '<leader>fk', fl.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>fm', fl.manpages, { desc = 'Man-Pages' })
    vim.keymap.set('n', '<leader>fb', fl.builtin, { desc = 'Builtin pickers' })
    -- TODO: I should implement _clipboard history_ in fzf-lua
    -- vim.keymap.set('n', '<leader>fy', _I need to implement it_, { desc = 'Clipboard history' })

    -- use fzf-lua for spelling suggestion
    vim.keymap.set('i', '<C-z>', function()
      fl.spell_suggest {
        winopts = {
          height = 0.4,
          width = 30,
          relative = 'cursor',
        },
      }
    end, { desc = 'Spelling suggestions' })
    vim.keymap.set('n', 'z=', function()
      fl.spell_suggest {
        winopts = {
          height = 0.4,
          width = 30,
          relative = 'cursor',
        },
      }
    end, { desc = 'Spelling suggestions' })

    -- application specific
    vim.keymap.set('n', '<leader>fZ', fl.zoxide, { desc = 'Zoxide directories' })
  end,
}
