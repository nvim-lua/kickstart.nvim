return {
  'vimwiki/vimwiki',
  keys = {
    '<leader>ww',
    --  "<leader>wt",
    --    { "<leader>wz", "<cmd>Vimwiki2HTML<cr>", desc = "Vimwiki2HTML" },
    --   { "<leader>wx", "<cmd>VimwikiAll2HTML<cr>", desc = "VimwikiAll2HTML" },
  },
  cmd = 'VimwikiIndex', -- Add this command to load Vimwiki
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/cavelazquez8-wiki/',
        syntax = 'markdown',
        ext = '.md',
        -- Custom Markdown to HTML converter
        --   custom_wiki2html = "~/.vim/autoload/vimwiki/convert.py",
        -- Auto update diary index
        index = 'mocs/main-moc',
        -- auto_diary_index = 1,
        links_space_char = '-', -- Replace spaces with hyphens in links
      },
      {
        path = '~/personal-wiki/',
        syntax = 'markdown',
        ext = '.md',
        index = 'mocs/main-moc',
        -- Custom Markdown to HTML converter
        --   custom_wiki2html = "~/.vim/autoload/vimwiki/convert.py",
        -- Auto update diary index
        -- auto_diary_index = 1,
        links_space_char = '-', -- Replace spaces with hyphens in links
      },
    }
    -- Register markdown files
    -- vim.g.vimwiki_ext2syntax = {
    -- ['.md'] = 'markdown',
    --   ['.markdown'] = 'markdown',
    --   ['.mdown'] = 'markdown',
    --}
    -- prevent md files from being coverted to vimwiki files
    vim.g.vimwiki_global_ext = 0
    -- Add .md extension to link
    vim.g.vimwiki_markdown_link_ext = 1
    -- vim.g.vimwiki_filetypes = { 'markdown' }
  end,
}
