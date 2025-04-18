return {
  {
    'olimorris/codecompanion.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
      prompt_library = {
        ['Generate PR description'] = {
          strategy = 'workflow',
          description = 'Generate PR description based on git diff',
          prompts = {
            {
              {
                role = 'system',
                content = 'You are an expert assistant and the best in analyzing git diffs.',
                opts = {
                  visible = false,
                },
              },
              {
                role = 'user',
                content = function()
                  vim.g.codecompanion_auto_tool_mode = true
                  return [[### Steps to Follow

You are required to create a Pull Request description based on the file at .github/pull_request_template.md. You must use @cmd_runner to read that file.

1. The file is in Portuguese, so you must complete the description in Portuguese as well.
2. Use @cmd_runner to get the git diff of the current branch, by using the command `git diff origin/HEAD`.
3. Based on that diff, you will generate a Pull Request description based on .github/pull_request_template.md.
4. If necessary, you can obtain the name of the branch by using the command `git rev-parse --abbrev-ref HEAD`.
5. Write the entire pull request description.]]
                end,
              },
            },
          },
        },
      },
    },
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   ft = { 'markdown', 'codecompanion' },
  -- },
}
