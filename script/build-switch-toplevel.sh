#!/bin/sh

set -e -x

DEVIP="192.168.1.38"
WD=$(cd "$(dirname $0)"; pwd;)

sh $WD/build-mobile-nixos.sh \
  -U root@$DEVIP -C ./nix/example.nix -A config.system.build.toplevel "$@"
