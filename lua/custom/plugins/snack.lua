local function open_pr_diff(picker, item, action)
  -- Get the current item if not provided
  item = item or picker:current()
  if not item then
    return
  end

  -- Get the gh_item if available (for gh_pr picker)
  local gh_item = item.gh_item or item
  if not gh_item.baseRefName or not gh_item.headRefName then
    Snacks.notify.error 'PR diff: Missing branch information'
    return
  end

  picker:close()

  local base_ref = gh_item.baseRefName
  local head_ref = gh_item.headRefName
  local pr_number = gh_item.number

  -- Fetch the PR head branch using gh (this ensures the branch is available)
  if pr_number then
    -- Use gh to fetch the PR branch - this handles remote branches correctly
    vim.fn.system('gh pr checkout ' .. pr_number .. ' --detach --force 2>&1')
  end

  -- Fetch both branches from origin to ensure they're available
  vim.fn.system('git fetch origin ' .. base_ref .. ' 2>&1')
  vim.fn.system('git fetch origin ' .. head_ref .. ' 2>&1')

  -- Use origin/ prefix for remote branches in DiffviewOpen
  -- This ensures we reference the remote branches correctly
  local diff_cmd = string.format('DiffviewOpen origin/%s...origin/%s', base_ref, head_ref)
  vim.cmd(diff_cmd)
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      enabled = true,
      show_hidden = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          hidden = true, -- Show hidden files by default
          ignored = false, -- Optional: show git-ignored files by default
        },
        gh_pr = {
          actions = {
            side_by_side = {
              desc = 'Open PR diff side-by-side',
              action = open_pr_diff,
            },
          },
          win = {
            input = {
              keys = {
                -- <C-s> in PR picker: Open side-by-side diff in DiffviewOpen
                ['<C-s>'] = { 'side_by_side', mode = { 'n', 'i' }, desc = 'Open PR diff side-by-side' },
              },
            },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader>gi',
      function()
        Snacks.picker.gh_issue()
      end,
      desc = 'GitHub Issues (open)',
    },
    {
      '<leader>gI',
      function()
        Snacks.picker.gh_issue { state = 'all' }
      end,
      desc = 'GitHub Issues (all)',
    },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'GitHub Pull Requests (open) - Press <C-s> in picker for side-by-side diff',
    },
    {
      '<leader>gP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'GitHub Pull Requests (all) - Press <C-s> in picker for side-by-side diff',
    },
  },
}
