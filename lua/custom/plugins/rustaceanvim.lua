return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  dependencies = { 'nvim-neotest/neotest' },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy',
              extra_args = {
                '--',
                '-W',
                'clippy::pedantic',
                '-W',
                'clippy::unwrap_used',
                '-W',
                'clippy::expect_used',
                '-W',
                'clippy::panic',
                '-W',
                'clippy::exit',
                '-W',
                'clippy::todo',
                '-W',
                'clippy::unimplemented',
                '-W',
                'clippy::dbg_macro',
                '-A',
                'clippy::module_name_repetitions',
              },
            },
            rustfmt = {
              extraArgs = { '+nightly' },
            },
          },
        },
      },
    }
  end,
}
