#!/bin/sh

die() { echo "$@">&2; exit 1; }

ATTR=
OUT=
ARGS=
CFG=
SYS="aarch64-linux"
TGT=pine64-pinephone
SSHUSER=
DOSWITCH=n
while test -n "$1" ; do
  case "$1" in
    -A) ATTR="$2"; shift ;;
    -o) OUT="$2"; shift ;;
    -C) CFG="$2"; shift ;;
    -S) SYS="x86_64-linux"; TGT=uefi-x86_64 ;;
    -U|--ssh-user) SSHUSER="$2"; shift ;;
    switch) DOSWITCH=y ;;
    *) ARGS="$ARGS $1" ;;
  esac
  shift
done

set -e -x

CWD=`pwd`
if test -z "$CFG" ; then
  if test -f "$CWD/nix/example.nix" ; then
    CFG="$CWD/nix/example.nix"
  else
    die "Doesn't know which configuration to build"
  fi
else
  test -f "$CFG" || die "'$CFG' is not a file"
fi

test -f "$CFG" || \
  die "Configuration '$CFG' is not a file"

export NIX_PATH=\
"nixpkgs=$CWD/modules/nixpkgs"

if test -z "$ATTR" ; then
  ATTR=build.disk-image
fi
if test -z "$OUT" ; then
  if test "$ATTR" = "build.disk-image" ; then
    OUT=result-mobile-nixos
  else
    OUT=result
  fi
fi

nix-build \
  --argstr device "$TGT" \
  --arg pkgs "import $CWD/modules/nixpkgs {}" \
  --arg configuration "import $CFG {system=\"$SYS\";}" \
  -A "$ATTR" \
  -o "$OUT" \
  modules/mobile-nixos \
  $ARGS

if test "$DOSWITCH" = "y" ; then
  if test -n "$SSHUSER" ; then
    RESULT=$(readlink "$OUT")
    nix-copy-closure --to "$SSHUSER" "$RESULT"
    ssh "$SSHUSER" nix-env --profile /nix/var/nix/profiles/system --set "$RESULT"
    ssh "$SSHUSER" "$RESULT/bin/switch-to-configuration" switch
  else
    die "-U SSHUSER is not set"
  fi
fi

