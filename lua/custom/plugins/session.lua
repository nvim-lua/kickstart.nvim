return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    allowed_dirs = { '~/development/nodejs/work' },
    -- log_level = 'debug',
  },
}
