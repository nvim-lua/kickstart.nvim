return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = 'davidmh/cspell.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local cspell = require 'cspell'
    local cspell_config = {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity['HINT']
      end,
      config = {
        cspell_config_dirs = { '~/.config/cspell/' },
        on_add_to_json = function(payload)
          os.execute(
            string.format(
              "jq -S '.words |= sort' %s > %s.tmp && mv %s.tmp %s",
              payload.cspell_config_path,
              payload.cspell_config_path,
              payload.cspell_config_path,
              payload.cspell_config_path
            )
          )
        end,
        on_add_to_dictionary = function(payload)
          os.execute(string.format('sort %s -o %s', payload.dictionary_path, payload.dictionary_path))
        end,
      },
    }
    null_ls.setup {
      sources = {
        cspell.diagnostics.with(cspell_config),
        cspell.code_actions.with(cspell_config),
      },
    }
  end,
}
