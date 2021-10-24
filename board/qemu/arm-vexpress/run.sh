#!/bin/sh

export PATH="/home/peterlin/Labs/buildroot/output/host/bin:${PATH}"
qemu-system-arm --version
exec qemu-system-arm -M vexpress-a9 \
                     -smp 4 \
                     -m 1G \
                     -kernel zImage \
                     -dtb vexpress-v2p-ca9.dtb \
                     -drive file=rootfs.ext2,if=sd,format=raw \
                     -append "console=ttyAMA0,115200 rootwait root=/dev/mmcblk0"  \
                     -net nic,model=lan9118 -net user  \
                     --fsdev local,id=fsdev0,path=$(pwd),security_model=none \
                     -device virtio-9p-device,fsdev=fsdev0,mount_tag=mydir \
                     -nographic 

                     # -S -s 
                     # target remote :1234

                     # mount -t 9p -o trans=virtio,version=9p2000.L mydir /mnt
