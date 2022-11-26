################################################################################
#
# minirq
#
################################################################################

MINIRQ_VERSION = 4c2bc78bbedab247fa92063b1e2fabff32f35f2b
MINIRQ_SITE = $(call github,lyctw,minirq,$(MINIRQ_VERSION))
MINIRQ_LICENSE = GPL-2.0
MINIRQ_LICENSE_FILES = COPYING

$(eval $(kernel-module))
$(eval $(generic-package))
