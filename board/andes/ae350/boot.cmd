setenv bootargs earlycon=sbi root=/dev/ram0 rootfstype=ramfs
load mmc 0:1 0x600000 Image
booti 0x600000 - $fdtcontroladdr
