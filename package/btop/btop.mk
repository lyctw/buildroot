################################################################################
#
# btop
#
################################################################################

BTOP_VERSION = 1.3.2
BTOP_SITE = $(call github,aristocratos,btop,v$(BTOP_VERSION))
BTOP_LICENSE = Apache-2.0
BTOP_LICENSE_FILES = LICENSE

define BTOP_BUILD_CMDS
	$(MAKE) -C $(@D) \
	CXX="$(TARGET_CXX)" \
	ADDFLAGS="$(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)" \
	QUIET=true
endef

define BTOP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/btop $(TARGET_DIR)/usr/bin/btop
endef

$(eval $(generic-package))
