{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) stdenv fetchurl atool;

  local = rec {
    callPackage = pkgs.lib.callPackageWith collection;

    collection = {

      jumpdrive = stdenv.mkDerivation rec {
        name = "jumpdrive";
        version = "0.8";
        device = "pine64-pinephone";

        buildInputs = [ atool ];

        src = fetchurl {
          url = "https://github.com/dreemurrs-embedded/Jumpdrive/releases/download/${version}/${device}.img.xz";
          sha256 = "1gkhv58973mzqacazlfy91hiklqmqp5ci9scq4vif3h75qjy1jd8";
        };

        buildCommand = ''
          . $stdenv/setup
          mkdir -pv $out/share
          aunpack $src
          cp -v *${device}.img $out/share/jumpdrive.img
        '';
      };
    };
  };
in
  local.collection
