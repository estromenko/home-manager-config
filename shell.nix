{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [nil nixd];
}
