{ pkgs ? import <nixpkgs> {} }:
with pkgs;

# Add more packages to this shell.
# https://search.nixos.org/packages
let
  pythonPackages = python312Packages;

in
mkShell {
  venvDir = "./.venv";
  buildInputs = [
    pythonPackages.python
    pythonPackages.venvShellHook
  ];

  postVenvCreation = ''
    pip install -r requirements.txt
  '';

  shellHook = ''
    LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/
  '';
}
