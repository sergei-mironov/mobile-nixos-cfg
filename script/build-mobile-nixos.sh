#!/bin/sh

die() { echo "$@">&2; exit 1; }

ATTR=
OUT=
ARGS=
CFG=
while test -n "$1" ; do
  case "$1" in
    -A) ATTR="$2"; shift ;;
    -o) OUT="$2"; shift ;;
    -C) CFG="$2"; shift ;;
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
fi

test -f "$CFG" || \
  die "Configuration '$CFG' is not a file"

export NIX_PATH=\
"nixpkgs=$CWD/modules/nixpkgs:"\
"mobile-nixos-configuration=$CFG"

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
  --argstr device pine64-pinephone \
  -A "$ATTR" \
  -o "$OUT" \
  modules/mobile-nixos \
  $ARGS

