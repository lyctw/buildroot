#!/bin/bash
set -x

QEMU="./output/host/bin/qemu-system-riscv64"

function run() {
$QEMU -M virt \
	-nographic -m 2G -smp 8 \
	-bios "./output/build/uboot-2022.01/spl/u-boot-spl" \
	-device loader,file="./output/build/uboot-2022.01/u-boot.itb",addr=0x80200000 \
	-device virtio-blk-device,drive=hd0 -drive file="./output/images/sdcard.img",id=hd0 \
	-device virtio-net-device,netdev=eth0  -netdev user,id=eth0 \
	-no-reboot

}

function debug() {
$QEMU -M virt \
	-nographic -m 2G -smp 8 \
	-bios "./output/build/uboot-2022.01/spl/u-boot-spl" \
	-device loader,file="./output/build/uboot-2022.01/u-boot.itb",addr=0x80200000 \
	-device virtio-blk-device,drive=hd0 -drive file="./output/images/sdcard.img",id=hd0 \
	-device virtio-net-device,netdev=eth0  -netdev user,id=eth0 \
	-no-reboot \
	-S -s
}


if [ "${1}" = "gdb" ]; then
./output/host/bin/riscv64-buildroot-linux-musl-gdb \
	-q -x "~/Github_repos/gdb-dashboard/.gdbinit" \
	-ex "target remote 0:1234" \
	-ex "dashboard -output /dev/pts/${2}"
	exit 0;
elif [ "${1}" = "run" ]; then
	run
	exit 0;
elif [ "${1}" = "debug" ]; then
	debug
	exit 0;
elif [ "${1}" = "" ]; then
	echo "Unsupported command"
	exit 1;
else
	echo "Unsupported command"
	exit 1;
fi
