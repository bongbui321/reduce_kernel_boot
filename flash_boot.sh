#!/bin/bash -e

if [ $# -ne 1 ]; then
  echo "Error: Exactly one argument is required."
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EDL="$DIR/../edl/edl"

echo "Getting active slot..."
CURRENT_SLOT="$($EDL getactiveslot 2>&1 | grep "Current active slot:" | cut -d ':' -f2- | sed 's/[[:blank:]]//g')"
echo "Current active slot: $CURRENT_SLOT"

if [ "$1" == "default" ]; then
  $EDL w boot_$CURRENT_SLOT /home/bongb/web_qdl/agnos_images/boot.img
else
  $EDL w boot_$CURRENT_SLOT "/home/bongb/agnos-builder/output/$1.img"
fi
