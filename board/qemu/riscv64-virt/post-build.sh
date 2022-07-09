#!/bin/sh
echo "post build"
cp $BINARIES_DIR/qemu.dtb $TARGET_DIR/boot
