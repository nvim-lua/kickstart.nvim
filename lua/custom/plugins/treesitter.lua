-- nvim-treesitter `main` branch (required for nvim 0.11+).
-- No more `require('nvim-treesitter.configs').setup{}`. Highlighting is
-- enabled per buffer via vim.treesitter.start() in a FileType autocmd.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  config = function()
    -- Parsers we want installed.
    local parsers = {
      'go', 'gowork', 'gomod', 'gosum',
      'terraform', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
      'java', 'json', 'nginx', 'sql', 'tmux', 'typescript', 'yaml',
      'python', 'rust', 'toml',
    }
    require('nvim-treesitter').install(parsers)

    -- Start treesitter highlighting + indent for any filetype with a parser.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('ts-start', { clear = true }),
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end
        local ok = pcall(vim.treesitter.start, ev.buf, lang)
        if ok then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Treesitter-aware textobjects + motion.
    local move = require('nvim-treesitter-textobjects.move')
    local select = require('nvim-treesitter-textobjects.select')

    -- Select: vif/vaf (function inner/outer), vac/vic (class), vaa/via (parameter).
    local function map_select(key, query)
      vim.keymap.set({ 'x', 'o' }, key, function()
        select.select_textobject(query, 'textobjects')
      end, { desc = 'TS select ' .. query })
    end
    map_select('af', '@function.outer')
    map_select('if', '@function.inner')
    map_select('ac', '@class.outer')
    map_select('ic', '@class.inner')
    map_select('aa', '@parameter.outer')
    map_select('ia', '@parameter.inner')
    map_select('al', '@loop.outer')
    map_select('il', '@loop.inner')

    -- Move: ]m / [m / ]M / [M between functions.
    vim.keymap.set({ 'n', 'x', 'o' }, ']m',
      function() move.goto_next_start('@function.outer', 'textobjects') end,
      { desc = 'TS next function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']M',
      function() move.goto_next_end('@function.outer', 'textobjects') end,
      { desc = 'TS next function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[m',
      function() move.goto_previous_start('@function.outer', 'textobjects') end,
      { desc = 'TS prev function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[M',
      function() move.goto_previous_end('@function.outer', 'textobjects') end,
      { desc = 'TS prev function end' })
  end,
}
