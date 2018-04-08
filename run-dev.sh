#!/bin/bash
SWIFT_VERSION="4.0.3-RELEASE"
BUILD_TOOLCHAIN_SWIFT="Toolchains/swift-$SWIFT_VERSION.xctoolchain/usr/bin/swift"

. bootstrap.sh

# if [ $(program_is_installed xcrun) == 1 ]; then
    # Generate Xcode projects
    # $BUILD_TOOLCHAIN_SWIFT package generate-xcodeproj
    # $BUILD_TOOLCHAIN_SWIFT package --package-path OnlinePlayground generate-xcodeproj
# fi

# Build OnlinePlayground
Toolchains/swift-4.0.3-RELEASE.xctoolchain/usr/bin/swift build --package-path OnlinePlayground --static-swift-stdlib --build-path OnlinePlayground/.build/swift-4.0.3-RELEASE -c debug -Xswiftc -DDEBUG
# Toolchains/swift-4.1-RELEASE.xctoolchain/usr/bin/swift build --package-path OnlinePlayground --static-swift-stdlib --build-path .build/swift-4.1-RELEASE -c debug -Xswiftc -DDEBUG

# Run
# Toolchains/swift-$SWIFT_VERSION.xctoolchain/usr/bin/swift run -c debug --static-swift-stdlib --build-path .build/swift-$SWIFT_VERSION -Xswiftc -DDEBUG &

# if [ $(program_is_installed npm) == 1 ]; then
#     $(npm bin)/webpack -w
# fi

# killall -9 PlaygroundServer

