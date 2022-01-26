#!/bin/sh

WD=$(cd "$(dirname $0)"; pwd;)

set -e -x

sh $WD/build-mobile-nixos.sh -S -C ./nix/phosh.nix -A outputs.uefi.vm "$@"
./result
