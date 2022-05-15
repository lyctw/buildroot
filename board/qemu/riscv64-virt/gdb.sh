#!/bin/bash
set -x
TOOLCHAIN="$PWD/../host/bin"
GDB="$TOOLCHAIN/riscv64-linux-gdb"
SCRIPT="$HOME/.gdbinit"
TARGET="0:1234"
ELF_JUMP="$PWD/fw_jump.elf"
ELF_PAYLOAD="$PWD/fw_payload.elf"

LINUX_DIR="$PWD/../build/linux-5.15.18"
# IMAGE="$LINUX_DIR/arch/riscv/boot/Image"
VMLINUX="$LINUX_DIR/vmlinux"

ADDR=$(${TOOLCHAIN}/riscv64-linux-readelf -a $VMLINUX | sed '29q;d' | cut -c 43-58)
TEXT_ADDR="0x${ADDR}"

function gdb-attach() {
$GDB -q -x $SCRIPT \
        -ex "target remote $TARGET" \
        -ex "set confirm off" \
        -ex "set pagination off" \
        -ex "dashboard -output /dev/pts/3" \
        -ex "add-symbol-file $VMLINUX $TEXT_ADDR" \
        -ex "add-symbol-file $ELF_JUMP 0x80000000"
}
gdb-attach

# DTB_FLATTENED_ADDR="0x2000000"

function gdb-jump_mode() {
$GDB -q -x $SCRIPT \
        -ex "target remote $TARGET" \
        -ex "set confirm off" \
        -ex "set pagination off" \
        -ex "monitor reset halt" \
        -ex "set \$ra=0" \
        -ex "set \$sp=0" \
        -ex "flushregs" \
        -ex "load" \
        -ex "restore $IMAGE binary 0x200000" \
        -ex "thread apply all set \$pc=0x0" \
        -ex "thread apply all set \$a0=\$mhartid" \
        -ex "thread apply all set \$a1=0xf2000000" \
        -ex "thread apply all set \$mcache_ctl=0x183f03L" \
        -ex "add-symbol-file $VMLINUX $TEXT_ADDR" \
        -ex "dashboard -output /dev/pts/36" \
        -ex "dashboard source -style height 25" \
        $ELF_JUMP 
}
# gdb-jump_mode


        # -ex "thread apply all set \$mcache_ctl=0x183f03L" \
        # -ex "dashboard memory watch $DTB_FLATTENED_ADDR" \
  # -ex "restore /local3/tmp/ae350_boot_mmc.dtb binary 0x20000000" \
  # -ex "add-symbol-file ../build/uboot-2022.01-rc4/u-boot 0x1200000" \
  # -ex "add-symbol-file ../build/uboot-2022.01-rc4/spl/u-boot-spl" \

function gdb-payload_mode() {
$GDB -q -x $SCRIPT \
        -ex "target remote $TARGET" \
        -ex "set confirm off" \
        -ex "set pagination off" \
        -ex "monitor reset halt" \
        -ex "set \$ra=0" \
        -ex "set \$sp=0" \
        -ex "flushregs" \
        -ex "load" \
        -ex "thread apply all set \$pc=0x0" \
        -ex "thread apply all set \$a0=\$mhartid" \
        -ex "thread apply all set \$a1=0xf2000000" \
        -ex "thread apply all set \$mcache_ctl=0x183f03L" \
        -ex "add-symbol-file $VMLINUX $TEXT_ADDR" \
        -ex "dashboard -output /dev/pts/36" \
        -ex "dashboard source -style height 25" \
        $ELF_PAYLOAD
}
# gdb-payload_mode

function u-boot-console () {
  ELF="$WORKSPACE/u-boot.official/spl/u-boot-spl"
  $GDB -x "~/local3/TOOLS/gdb-dashboard/.gdbinit" \
       -ex "target remote $TARGET" \
       -ex "set confirm off" \
       -ex "set pagination off" \
       -ex "monitor reset halt" \
       -ex "set \$ra=0" \
       -ex "set \$sp=0" \
       -ex "flushregs" \
       -ex "load" \
       -ex "restore $WORKSPACE/u-boot.official/u-boot.itb binary 0x00200000" \
       -ex "restore $WORKSPACE/linux/arch/riscv/boot/Image binary 0x2000000" \
       -ex "thread apply all set \$pc=&_start" \
       -ex "thread apply all set \$a0=\$mhartid" \
       -ex "thread apply all set \$a1=0xf2000000" \
       -ex "add-symbol-file $WORKSPACE/opensbi/build/platform/andes/ae350/firmware/fw_dynamic.elf 0x0" \
       -ex "add-symbol-file $WORKSPACE/u-boot.official/u-boot 0x1200000" \
       -ex "add-symbol-file $WORKSPACE/u-boot.official/spl/u-boot-spl" \
       -ex "dashboard -output /dev/pts/36" \
       -ex "dashboard source -style height 25" \
       $ELF

# booti 0x02000000 - $fdtcontroladdr
}
