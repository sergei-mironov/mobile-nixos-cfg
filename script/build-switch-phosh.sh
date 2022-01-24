#!/bin/sh

set -e -x

DEVIP="192.168.1.38"
WD=$(cd "$(dirname $0)"; pwd;)

sh $WD/build-mobile-nixos.sh -C ./nix/phosh.nix -A config.system.build.toplevel "$@"
nix-copy-closure --to root@$DEVIP `readlink ./result`
ssh root@$DEVIP nix-env --profile /nix/var/nix/profiles/system --set `readlink ./result`
ssh root@$DEVIP `readlink ./result`/bin/switch-to-configuration switch
