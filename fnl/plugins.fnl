(local install_path
       (.. (vim.fn.stdpath :data) :/site/pack/packer/start/packer.nvim))

(var is_bootstrap false)

(when (< 0 (vim.fn.empty (vim.fn.glob install_path)))
  (set is_bootstrap true)
  (vim.fn.system [:git
                  :clone
                  :--depth
                  :1
                  "https://github.com/wbthomason/packer.nvim"
                  install_path])
  (vim.cmd "packadd packer.nvim"))

(let [packer (require :packer)]
  (packer.startup (fn [use]
                    (use :wbthomason/packer.nvim)
                    ;; Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
                    (local (has_plugins plugins)
                           (pcall require :custom.plugins))
                    (when has_plugins
                      (plugins (use)))
                    (when is_bootstrap
                      (packer.sync)))))

(when is_bootstrap
  (print "==================================")
  (print "    Plugins are being installed")
  (print "    Wait until Packer completes,")
  (print "       then restart nvim")
  (print "==================================")
  (return))
