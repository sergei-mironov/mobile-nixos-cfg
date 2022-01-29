{ pkgs ?  import <nixpkgs> {}
, stdenv ? pkgs.stdenv
} :
let
  local = rec {
    callPackage = pkgs.lib.callPackageWith collection;

    collection = rec {
      shell = pkgs.mkShell {
        name = "shell";
        buildInputs = [];
        shellHook = with pkgs; ''
          if test -f ./env.sh ; then
            . ./env.sh
          fi
        '';
      };
    };
  };
in
  local.collection

