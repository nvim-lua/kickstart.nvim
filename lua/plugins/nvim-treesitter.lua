return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'python', 'rust',
        'javascript', 'typescript', 'tsx', 'json', 'yaml', 'query',
        'vim', 'vimdoc', 'comment', 'regex', 'go', 'gomod', 'gosum',
      }

      local nts = require('nvim-treesitter')
      local installed = nts.get_installed and nts.get_installed('parsers') or {}
      local have = {}
      for _, p in ipairs(installed) do have[p] = true end
      local missing = {}
      for _, p in ipairs(parsers) do
        if not have[p] then table.insert(missing, p) end
      end
      if #missing > 0 then nts.install(missing) end

      local max_filesize = 100 * 1024
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
          if not lang then return end
          local ok_p = pcall(vim.treesitter.language.add, lang)
          if not ok_p then return end

          local fname = vim.api.nvim_buf_get_name(buf)
          local ok, stats = pcall(vim.loop.fs_stat, fname)
          if ok and stats and stats.size > max_filesize then return end

          pcall(vim.treesitter.start, buf, lang)

          if lang ~= 'yaml' then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
  },
}
