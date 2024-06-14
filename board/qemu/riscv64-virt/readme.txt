Run Linux in emulation with:

  qemu-system-riscv64 -M virt -cpu rv64,zkr=on -dtb qemu_rv64_virt_domain.dtb -m 4096 -smp 2 -semihosting-config enable=on,target=native -serial tcp:127.0.0.1:64320,server -bios u-boot-spl -device loader,file=u-boot.itb,addr=0x80200000 -device virtio-blk-device,drive=hd0 -drive format=raw,file=sdcard.img,id=hd0 -device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2200-:22 -nographic # qemu_riscv64_virt_defconfig

  qemu-system-riscv64 -M virt -bios none -kernel output/images/Image -append "rootwait root=/dev/vda ro" -drive file=output/images/rootfs.ext2,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -nographic -cpu rv64,mmu=off -netdev user,id=net0 -device virtio-net-device,netdev=net0 # qemu_riscv64_nommu_virt_defconfig

The login prompt will appear in the terminal that started Qemu.

Debug:

  $ qemu-system-riscv ... -S -gdb tcp::4680

  Another terminal:

  $ ${CROSS_COMPILE}gdb -ex "target remote 127.0.0.1:4680"
