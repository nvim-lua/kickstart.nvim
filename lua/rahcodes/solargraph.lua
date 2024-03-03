local lsp = require 'lspconfig'
lsp.solargraph.setup {
  cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", '--stdio' },
  filetypes = { "ruby", "rakefile" },
  settings = {
    solargraph = {
      -- root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
      -- root_dir = root_pattern("Gemfile", ".git"),
      settings = {
        solargraph = {
          autoformat = true,
          completion = true,
          diagnostic = true,
          folding = true,
          references = true,
          rename = true,
          symbols = true
        }
      }
    },
  }
}
