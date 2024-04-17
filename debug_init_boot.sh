#!/bin/bash
set -e

if [ $# -ne 1 ]; then
  echo "Error: Exactly one argument is required."
  exit 1
fi

DEST_DIR=/home/bongb/reduce_kernel_boot

ssh c3x "dmesg | /data/boot_debug/bootgraph.pl > /tmp/boot.svg"
scp c3x:/tmp/boot.svg "$DEST_DIR/$1.svg"
google-chrome "$DEST_DIR/$1.svg"

