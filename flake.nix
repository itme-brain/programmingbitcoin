{
  description = "Python Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    py = pkgs.python310Packages;
  in
  {
  packages.${system}.default = with pkgs;
    mkShell {
      buildInputs = with py; [
        glibc
        python
        venvShellHook
      ];
      venvDir = "./.venv";
      postVenvCreation = ''
        unset SOURCE_DATE_EPOCH
        pip install -r requirements.txt
      '';
      postShellHook = ''
        unset SOURCE_DATE_EPOCH
        export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/
      '';
    };
  };
}
