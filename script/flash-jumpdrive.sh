#!/bin/sh

die() {
  echo "$@" >&2 ; exit 1
}

lsdevs() {
  lsblk -l -p -o RM,TYPE,PATH,VENDOR,MODEL,SERIAL,SIZE | grep "^ 1 disk"
}

set -e
nix-build -A jumpdrive -o result-jumpdrive
IMG=./result-jumpdrive/share/jumpdrive.img
file "$IMG" | grep "boot sector"

DEVLINE=`lsdevs | sed 's/  */ /g' | sed 's/^ //'`
test $(echo "$DEVLINE" | wc -l) = 1
DEV=$(echo "$DEVLINE" | awk '{print $3}')
test -b "$DEV"

echo "Found $DEVLINE"
echo -n "Flash $DEV [y/n]? "; read ans
test "$ans" = "y"

if mount | grep -q "$DEV" ; then
  for d in $(mount | grep "$DEV" | awk '{print $1}') ; do
    echo "Unmounting $d"
    sudo umount "$d"
  done
fi

sudo dd if="$IMG" of="$DEV" bs=1M status=progress conv=fsync
