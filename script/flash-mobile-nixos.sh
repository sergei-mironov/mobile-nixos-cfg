#!/bin/sh

die() { echo "$@" >&2; exit 1; }
WD=$(cd "$(dirname $0)"; pwd;)
DEVL="/dev/disk/by-id/usb-JumpDriv_e_eMMC_Jumpdrive-0:0"
set -e
# set -x

sh $WD/build-mobile-nixos.sh
IMG=$(readlink -f ./result-mobile-nixos)
test -f "$IMG" || \
  die "$IMG is not a file"
file "$IMG" | grep -q 'boot sector' || \
  die "$IMG is not a boot-sector image"

DEV=$(readlink -f "$DEVL")
test -b "$DEV" || \
  die "$DEVL ($DEV) is not a block device"
lsblk -l -p -o RM,TYPE,PATH "$DEV" | grep -q "^ 1 disk" || \
  die "$DEVL ($DEV) is not a removable disk"

echo "Using $DEVL ($DEV)"
echo -n "Flash $DEV with $IMG [y/n]? "; read ans
test "$ans" = "y"

if mount | grep -q "$DEV" ; then
  for d in $(mount | grep "$DEV" | awk '{print $1}') ; do
    echo "Unmounting $d"
    sudo umount "$d"
  done
fi

sudo dd if="$IMG" of="$DEV" bs=8M oflag=sync,direct status=progress conv=fsync
