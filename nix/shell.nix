{pkgs, ...}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    fennel
    fnlfmt
    alejandra
  ];
}
