#!/bin/sh

CWD=`pwd`
export NIX_PATH="nixpkgs=$CWD/modules/nixpkgs:mobile-nixos-configuration=$CWD/nix/local.nix"
echo $NIX_PATH
nix-build \
  --argstr device pine64-pinephone \
  -A build.disk-image \
  -o result-mobile-nixos \
  modules/mobile-nixos \
  "$@"

