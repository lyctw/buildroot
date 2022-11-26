################################################################################
#
# The Linux kernel programming guide
#
################################################################################

LKMPG_VERSION = e14f21ea9cfdead6529a6f960cdbda8d1ccce203
LKMPG_SITE = $(call github,lyctw,lkmpg-examples,$(LKMPG_VERSION))
LKMPG_LICENSE = GPL-2.0
LKMPG_LICENSE_FILES = COPYING

$(eval $(kernel-module))
$(eval $(generic-package))
