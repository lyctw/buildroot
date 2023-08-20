#!/bin/sh
set -x
(
BINARIES_DIR="${0%/*}/"
cd ${BINARIES_DIR}

mode_serial=false
mode_ssh_port=false
while [ "$1" ]; do
    case "$1" in
    --serial-only|serial-only) mode_serial=true; shift;;
    --ssh-port|-ssh-port)
        mode_ssh_port=true
        shift
        SSH_PORT="$1"
        shift
        ;;
    --) shift; break;;
    *) echo "unknown option: $1" >&2; exit 1;;
    esac
done

if ${mode_serial}; then
    EXTRA_ARGS='-nographic'
elif ${mode_ssh_port}; then
    if [ -z "$SSH_PORT" ]; then
        echo "missing SSH port number" >&2
        exit 1
    fi
else
    EXTRA_ARGS=''
fi

export PATH="${PWD}/../host/bin:${PATH}"

which qemu-system-riscv64
exec qemu-system-riscv64 \
	-nographic \
	-M virt \
	-m 2G \
	-smp 2 \
	-bios u-boot-spl \
	-device loader,file=u-boot.itb,addr=0x80200000 \
	-device virtio-blk-device,drive=hd0 \
	-drive file=sdcard.img,format=raw,id=hd0 \
	-device virtio-net-device,netdev=eth0 \
	-netdev user,id=eth0 \
	${EXTRA_ARGS}
)
