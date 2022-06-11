#!/bin/sh
set -x
GDB="$PWD/output/host/bin/riscv64-buildroot-linux-gnu-gdb"
(
BINARIES_DIR="${0%/*}/"
cd ${BINARIES_DIR}

if [ "${1}" = "serial-only" ]; then
    EXTRA_ARGS='-nographic'
elif [ "${1}" = "debug" ]; then
    EXTRA_ARGS='-S -s' # port=1234

    # $GDB -q -x "~/.gdbinit" \
    #      -ex "target remote 0:1234" \
    #      -ex "dashboard -output /dev/pts/X" \
    #      "./fw_jump.elf"
elif [ "${1}" = "virtfs" ]; then
    EXTRA_ARGS="--fsdev local,id=fsdev0,path=`pwd`,security_model=none \
                -device virtio-9p-pci,fsdev=fsdev0,mount_tag=mydir"
    # busybox: $ mount -t 9p -o trans=virtio,version=9p2000.L mydir /mnt
else
    EXTRA_ARGS=''
fi

export PATH="/home/peterlin/Labs/BR_QEMU_RV64/output/host/bin:${PATH}"
TELNET_PORT="8888"

exec qemu-system-riscv64 \
        -smp 2 \
        -M virt \
        -bios fw_jump.elf \
        -kernel Image \
        -append "rootwait root=/dev/vda rw" \
        -drive file=rootfs.ext2,format=raw,id=hd0 \
        -device virtio-blk-device,drive=hd0 \
        -netdev user,id=net0,hostfwd=tcp::${TELNET_PORT}-:22 \
        -device virtio-net-device,netdev=net0 \
        -nographic ${EXTRA_ARGS}
)

# connet from host: ssh root@127.0.0.1 -p ${TELNET_PORT}"

