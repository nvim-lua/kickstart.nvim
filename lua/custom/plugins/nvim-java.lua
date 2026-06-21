-- nvim-java: full Java IDE layer on top of jdtls (tests, DAP, refactors, Spring Boot).
-- https://github.com/nvim-java/nvim-java
--
-- This file is loaded by the custom-plugins loader (lua/custom/plugins/init.lua),
-- which runs in Section 10 of init.lua -- AFTER the LSP section (Section 6). The LSP
-- section deliberately SKIPS jdtls in its `vim.lsp.config`/`vim.lsp.enable` loop, so
-- this is the single place jdtls is configured and enabled. That guarantees the
-- required order (`require('java').setup()` before `vim.lsp.enable('jdtls')`) and
-- avoids a second, competing vanilla jdtls setup.
--
-- Requirements (nvim-java README, vim.pack install): Neovim 0.11.5+. jdtls,
-- java-debug-adapter and java-test are provided via Mason -- jdtls from the LSP
-- section's mason-tool-installer, java-debug-adapter + java-test from
-- lua/kickstart/plugins/debug.lua (mason-nvim-dap). nvim-dap and nui.nvim are also
-- pulled in by debug.lua / neo-tree.lua respectively; re-listing them here is
-- idempotent and keeps this spec self-contained per the README.
vim.pack.add {
  { src = 'https://github.com/JavaHello/spring-boot.nvim', version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0' },
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-java/nvim-java',
}

-- Must run BEFORE jdtls is enabled: it patches the jdtls config so the language
-- server is launched with the java-test / java-debug-adapter bundles.
require('java').setup()

-- Enable jdtls using the config nvim-java just registered (the new Neovim 0.11+ API).
vim.lsp.enable 'jdtls'
