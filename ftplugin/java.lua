local config = {
  cmd = { vim.fn.expand '/home/neox/.local/share/nvim/mason/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  flags = { debounce_text_changes = 80 },
}
require('jdtls').start_or_attach(config)
