{pkgs, ...}: let
  aniseed = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "aniseed";
    version = "v3.32.0";
    src = pkgs.fetchFromGitHub {
      owner = "Olical";
      repo = "aniseed";
      rev = "a7445c340fb7a0529f3c413eb99d3f8d29f50ba2";
      sha256 = "sha256-KTNImPjifuoj0/ahuYcqMtutGgOR4XnYruv/JVjyrTk=";
    };
    meta.homepage = "https://github.com/Olical/aniseed";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "init.vim";
    phases = ["installPhase" "fixupPhase"];
    installPhase = ''
      mkdir $out
      cat << EOF > $out/init.vim
      set runtimepath+=${aniseed}
      let g:aniseed#env = v:true
      EOF
    '';
  }
