#!/bin/sh
set -x
QEMU_BOARD_DIR="$(dirname $0)"

if [ ! -L ${BINARIES_DIR}/run.sh ]; then
  ln -s $PWD/${QEMU_BOARD_DIR}/run.sh ${BINARIES_DIR}/run.sh
fi
