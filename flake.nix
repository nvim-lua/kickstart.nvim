{
  description = "Personal Neovim configuration based on kickstart.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Custom Neovim package with this configuration
        neovimConfig = pkgs.stdenv.mkDerivation {
          name = "kickstart-nvim-config";
          src = self;

          installPhase = ''
            mkdir -p $out
            cp -r init.lua $out/
            cp -r lua $out/
            cp -r doc $out/
            ${pkgs.lib.optionalString (builtins.pathExists ./AGENT.md) "cp AGENT.md $out/"}
          '';
        };

        neovim-kickstart = pkgs.neovim.override {
          configure = {
            customRC = ''
              lua << EOF
              -- Set XDG_CONFIG_HOME to point to our config
              vim.env.NVIM_APPNAME = vim.env.NVIM_APPNAME or "nvim-kickstart"

              -- Load the kickstart configuration
              dofile("${neovimConfig}/init.lua")
              EOF
            '';
          };
        };
      in
      {
        packages = {
          default = neovim-kickstart;
          neovim = neovim-kickstart;
        };
      }
    );
}
