{
  description = "Setup aniseed";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;
        # config.allowBroken = true;
      };
      aniseed = pkgs.callPackage ./nix/aniseed.nix {};
    in {
      devShell = import ./nix/shell.nix {
        inherit pkgs;
      };
      defaultPackage = aniseed;
      packages = flake-utils.lib.flattenTree {
        inherit aniseed;
      };
    });
}
