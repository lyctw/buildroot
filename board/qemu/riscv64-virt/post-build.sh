#!/bin/sh
BOARD_DIR="$(dirname $0)"

if [ -L "$BINARIES_DIR/start-qemu.sh" ]; then
    echo "Symbolic link has created"
    exit 0
fi
ln -s $PWD/board/qemu/start-qemu.sh $BINARIES_DIR
