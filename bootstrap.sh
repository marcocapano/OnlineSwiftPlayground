#!/bin/bash

# Bootstrap Swift environment for Playground

function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

function install_toolchain {
    SWIFT_VERSION=$1
    SWIFT_SYSTEM=$2
    if [ ! -d "Toolchains/swift-$SWIFT_VERSION-RELEASE.xctoolchain" ]; then
        case "$SWIFT_SYSTEM" in 
        *osx*)
            mkdir -p Toolchains/swift-$SWIFT_VERSION-RELEASE.xctoolchain
            # download
            curl -O https://swift.org/builds/swift-$SWIFT_VERSION-release/xcode/swift-$SWIFT_VERSION-RELEASE/swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.pkg
            # extract
            xar -xf swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.pkg -C Toolchains/
            tar -xzf Toolchains/swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM-package.pkg/Payload -C Toolchains/swift-$SWIFT_VERSION-RELEASE.xctoolchain
            # cleanup
            rm Toolchains/Distribution
            rm -r Toolchains/swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM-package.pkg
            rm -r swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.pkg
            ;;
        *ubuntu*)
            mkdir -p Toolchains/swift-$SWIFT_VERSION-RELEASE.xctoolchain
            # download
            curl -O https://swift.org/builds/swift-$SWIFT_VERSION-release/ubuntu1404/swift-$SWIFT_VERSION-RELEASE/swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.tar.gz
            # extract
            tar -xvzf swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.tar.gz -C Toolchains/swift-$SWIFT_VERSION-RELEASE.xctoolchain --strip-components=1
            # cleanup
            rm -rf swift-$SWIFT_VERSION-RELEASE-$SWIFT_SYSTEM.tar.gz
            ;;
        esac
    fi
}

if [ $(program_is_installed xcrun) == 1 ]; then
    # Install Toolchains
    install_toolchain "4.1" "osx"
    install_toolchain "4.0.3" "osx"
else
    # Install Toolchains
    install_toolchain "4.1" "ubuntu14.04"
    install_toolchain "4.0.3" "ubuntu14.04"
fi
