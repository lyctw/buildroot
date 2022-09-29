################################################################################
#
# hello_world
#
################################################################################
ERRNO_LOCAL_PATH:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
ERRNO_DIR_NAME := errno
ERRNO_APP_NAME := errno

ERRNO_SITE = $(ERRNO_LOCAL_PATH)/src
ERRNO_SITE_METHOD = local


define ERRNO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) 
endef

define ERRNO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(ERRNO_DIR_NAME).out $(TARGET_DIR)/usr/bin/$(ERRNO_APP_NAME)
endef

$(eval $(generic-package))
