
XCODE_VERSION_GE_4 := $(shell expr `xcodebuild -version | sed -nE 's/^Xcode ([0-9]+).*/\1/p'` \>= 4)
XCODE_VERSION_GE_10 := $(shell expr `xcodebuild -version | sed -nE 's/^Xcode ([0-9]+).*/\1/p'` \>= 10)

XCODEBUILD_OPTIONS=-project 'CommandLineSnapShotMounter.xcodeproj' CONFIGURATION_BUILD_DIR=$(CURDIR)/build DEPLOYMENT_LOCATION=NO

ifeq "$(XCODE_VERSION_GE_10)" "1"
	XCODEBUILD_OPTIONS += ARCHS=x86_64 VALID_ARCHS=x86_64 ONLY_ACTIVE_ARCH=YES
endif

ifeq "$(XCODE_VERSION_GE_4)" "1"
	XCODEBUILD_OPTIONS += -scheme 'CommandLineSnapShotMounter'
#	BUILD_ACTION=running
else
	XCODEBUILD_OPTIONS += -configuration 'Release'
endif

CommandLineSnapShotMounter:
	@echo "Building CommandLineSnapShotMounter..."
	@/usr/bin/xcodebuild $(XCODEBUILD_OPTIONS) $(BUILD_ACTION)  >/dev/null
	@echo [XCODE] $(PROGRAMS)
	@echo "Building Applications CommandLineSnapShotMounter"
	@$(CURDIR)/CreateApp.sh
		

clean:
	@/usr/bin/xcodebuild $(XCODEBUILD_OPTIONS) clean  >/dev/null
	@rm -rf build *~
	@echo [CLEAN] $(PROGRAMS)

.PHONY: CommandLineSnapShotMounter clean
