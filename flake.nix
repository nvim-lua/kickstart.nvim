{
  description = "Personal Neovim configuration based on kickstart.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Home Manager module
      homeManagerModule = { config, lib, pkgs, ... }: {
        options.programs.neovim-kickstart = {
          enable = lib.mkEnableOption "kickstart.nvim configuration";
        };

        config = lib.mkIf config.programs.neovim-kickstart.enable {
          home.file.".config/nvim" = {
            source = self;
            recursive = true;
          };

          # Install Neovim package and recommended dependencies
          home.packages = [ self.packages.${pkgs.system}.default ] ++ (with pkgs; [
            ripgrep
            fd
            gcc
            gnumake
            git
          ]);
        };
      };
    in
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

        devShells.default = pkgs.mkShell {
          buildInputs = [
            neovim-kickstart
            pkgs.ripgrep
            pkgs.fd
            pkgs.gcc
            pkgs.gnumake
            pkgs.git
          ];

          shellHook = ''
            echo "Neovim kickstart development environment"
            echo "Run 'nvim' to start Neovim with the kickstart configuration"
          '';
        };
      }
    ) // {
      # Home Manager module (not system-specific)
      homeManagerModules.default = homeManagerModule;
      homeManagerModules.neovim-kickstart = homeManagerModule;
    };
}
