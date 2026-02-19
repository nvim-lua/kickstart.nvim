vim.o.hlsearch = false                               -- Set highlight on search
vim.wo.number = true                                 -- Make line numbers default
vim.o.mouse = 'a'                                    -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'                      -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true                             -- Enable break indent
vim.o.undofile = true                                -- Save undo history
vim.o.ignorecase = true                              -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true                               -- smart case
vim.wo.signcolumn = 'yes'                            -- Keep signcolumn on by default
vim.o.updatetime = 250                               -- Decrease update time
vim.o.timeoutlen = 300                               -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.backup = false                                 -- creates a backup file
vim.o.writebackup = false                            -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.completeopt = 'menuone,noselect'               -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true                         -- set termguicolors to enable highlight groups
vim.o.whichwrap = 'bs<>[]hl'                         -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.wrap = false                                   -- display lines as one long line
vim.o.linebreak = true                               -- companion to wrap don't split words
vim.o.scrolloff = 0                                  -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8                              -- minimal number of screen columns either side of cursor if wrap is `false`
vim.o.relativenumber = true                          -- set relative numbered lines
vim.o.numberwidth = 4                                -- set number column width to 2 {default 4}
vim.o.shiftwidth = 4                                 -- the number of spaces inserted for each indentation
vim.o.tabstop = 2                                    -- insert n spaces for a tab
vim.o.softtabstop = 4                                -- Number of spaces that a tab counts for while performing editing operations
vim.o.expandtab = true                               -- convert tabs to spaces
vim.o.cursorline = true                              -- highlight the current line
vim.o.splitbelow = true                              -- force all horizontal splits to go below current window
vim.o.splitright = true                              -- force all vertical splits to go to the right of current window
vim.o.swapfile = false                               -- creates a swapfile
vim.o.smartindent = true                             -- make indenting smarter again
vim.o.showmode = false                               -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 0                                -- always show tabs
vim.o.backspace = 'indent,eol,start'                 -- allow backspace on
vim.o.pumheight = 10                                 -- pop up menu height
vim.o.conceallevel = 0                               -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8'                         -- the encoding written to a file
vim.o.cmdheight = 1                                  -- more space in the neovim command line for displaying messages
vim.o.autoindent = true                              -- copy indent from current line when starting new one
vim.opt.shortmess:append 'c'                         -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-'                         -- hyphenated words recognized by searches
vim.opt.formatoptions:remove { 'c', 'r', 'o' }       -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use


-- -- Ensure fold method is set (syntax-based folding is great for Nim)
-- vim.o.foldmethod = "syntax"
-- vim.o.foldenable = true -- Enable folding at startup
-- vim.o.foldlevel = 99 -- Open all folds by default



-- Use Treesitter for better folding (Recommended)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Set fold level
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Keep folds open by default



-- Markdown: enable concealment for render-markdown.nvim rendering
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"

    -- ]e/[e and ]w/[w navigate spell errors (mirrors diagnostic nav in code files)
    vim.keymap.set("n", "]e", "]s", { buffer = true, remap = true, desc = "Next spell error" })
    vim.keymap.set("n", "[e", "[s", { buffer = true, remap = true, desc = "Prev spell error" })
    vim.keymap.set("n", "]w", "]s", { buffer = true, remap = true, desc = "Next spell error" })
    vim.keymap.set("n", "[w", "[s", { buffer = true, remap = true, desc = "Prev spell error" })

    -- K: spell suggestions picker when on a misspelled word, fallback to LSP hover
    vim.keymap.set("n", "K", function()
      local bad = vim.fn.spellbadword()
      if bad[1] ~= "" then
        local word = bad[1]
        local suggestions = vim.fn.spellsuggest(word, 10)
        local items = {}
        for _, s in ipairs(suggestions) do
          table.insert(items, s)
        end
        table.insert(items, "── dictionary ──")
        table.insert(items, "Add to dictionary: " .. word)
        table.insert(items, "Mark as bad: " .. word)

        vim.ui.select(items, {
          prompt = "Spell: '" .. word .. "'",
        }, function(choice)
          if not choice or choice == "── dictionary ──" then return end
          if choice == "Add to dictionary: " .. word then
            vim.cmd("normal! zg")
          elseif choice == "Mark as bad: " .. word then
            vim.cmd("normal! zw")
          else
            vim.cmd("normal! ciw" .. choice)
          end
        end)
        return
      end
      -- fallback: LSP hover (e.g. if marksman is installed later)
      pcall(vim.lsp.buf.hover)
    end, { buffer = true, desc = "Spell suggestions / hover" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "templ",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})
