return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    allowed_dirs = { '~/nodejs/work/*', '~/nodejs/private/*', '~/nodejs/playground/', '~/metadata/work/*', '~/golang/*' },
  },
}
