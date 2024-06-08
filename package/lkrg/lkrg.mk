################################################################################
#
# lkrg
#
################################################################################

LKRG_VERSION = master
LKRG_SITE = $(call github,lkrg-org,lkrg,$(LKRG_VERSION))
LKRG_LICENSE = GPL-2.0
LKRG_LICENSE_FILES = LICENSE

$(eval $(kernel-module))
$(eval $(generic-package))
