-- nvim-java: Java IDE layer on top of jdtls.
-- https://github.com/nvim-java/nvim-java
--
-- NOTE: This only installs the plugin (mirroring the user's original
-- `return { 'nvim-java/nvim-java' }` spec). It is NOT yet initialized, so jdtls
-- currently runs vanilla. Wiring (`require('java').setup()`) is finished later.
vim.pack.add { 'https://github.com/nvim-java/nvim-java' }
