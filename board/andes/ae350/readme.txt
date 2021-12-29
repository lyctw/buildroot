Intro
=====

Andestech AE350 Platform

The AE350 prototype demonstrates the AE350 platform on the FPGA.

How to build it
===============

Configure Buildroot
-------------------

  $ make ae350_andestar45_defconfig

If you want to customize your configuration:

  $ make menuconfig

Build everything
----------------
Note: you will need to access to the network, since Buildroot will
download the packages' sources.

  $ make

Result of the build
-------------------

After building, you should obtain the following files:

  output/images/
  |-- Image
  |-- ae350.dtb
  |-- boot.scr
  |-- boot.vfat
  |-- fw_dynamic.bin
  |-- fw_dynamic.elf
  |-- fw_jump.bin
  |-- fw_jump.elf
  |-- rootfs.cpio
  |-- rootfs.ext2
  |-- rootfs.ext4 -> rootfs.ext2
  |-- rootfs.tar
  |-- sdcard.img
  |-- u-boot-spl.bin
  `-- u-boot.itb


Copy the sdcard.img to a SD card with "dd":

  $ sudo dd if=sdcard.img of=/dev/sdX bs=4096

Your SD card partition should be:

  Disk /dev/mmcblk0: 31457280 sectors, 3072M
  Logical sector size: 512
  Disk identifier (GUID): 546663ee-d2f1-427f-93a5-5c7b69dd801c
  Partition table holds up to 128 entries
  First usable sector is 34, last usable sector is 385062

  Number  Start (sector)    End (sector)  Size Name
       1              34          262177  128M u-boot
       2          262178          385057 60.0M rootfs

Insert SD card and reset the board, should boot Linux from mmc.
