#!/bin/sh


ATTR=
OUT=
ARGS=
while test -n "$1" ; do
  case "$1" in
    -A) ATTR="$2"; shift ;;
    -o) OUT="$2"; shift ;;
    *) ARGS="$ARGS $1" ;;
  esac
  shift
done

set -x

CWD=`pwd`
export NIX_PATH=\
"nixpkgs=$CWD/modules/nixpkgs:"\
"mobile-nixos-configuration=$CWD/nix/local.nix"

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

