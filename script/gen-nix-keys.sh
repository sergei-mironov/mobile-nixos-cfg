#!/bin/sh

# This script is probably not really needed

DEVIP=192.168.1.38

set -e -x
rm -f _signing-key.pub _signing-key.sec || true
umask 277 && openssl genrsa -out _signing-key.sec 2048
openssl rsa -in _signing-key.sec -pubout > _signing-key.pub

! test -f /etc/nix/signing-key.sec
sudo cp _signing-key.sec /etc/nix/signing-key.sec
ssh nixos@$DEVIP rm -f /home/nixos/signing-key.pub || true
scp _signing-key.pub nixos@$DEVIP:/home/nixos/signing-key.pub
ssh nixos@$DEVIP sudo -S mv -f /home/nixos/signing-key.pub /etc/nix/signing-key.pub
