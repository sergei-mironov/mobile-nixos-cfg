#!/bin/sh

CWD=`pwd`

NIX_PATH="nixpkgs=$CWD/modules/nixpkgs" \
  nix-build $CWD/modules/mobile-nixos \
    --argstr device pine64-pinephone -A build.u-boot
