ifeq ($(shell [ -f ./framework/makefiles/common.mk ] && echo 1 || echo 0),0)
all clean package install::
	git submodule update --init
	./framework/git-submodule-recur.sh init
	$(MAKE) $(MAKEFLAGS) MAKELEVEL=0 $@
else

THEOS_DEVICE_IP=iphone
GO_EASY_ON_ME=1

TWEAK_NAME = CalendarAlertGenerator
CalendarAlertGenerator_OBJC_FILES = CalendarAlertGenerator.xm
CalendarAlertGenerator_FRAMEWORKS = EventKit

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

endif
