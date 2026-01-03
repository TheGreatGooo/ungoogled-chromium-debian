#!/bin/bash
set -e
pushd build/src
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
sed -i "s|CLANG_REVISION = 'llvmorg-22-init-8940-g4d4cb757'|CLANG_REVISION = '292dc2b86f66e39f4b85ec8b185fd8b60f5213ce'|g" "$WORKSPACE/build/src/tools/rust/update_rust.py"
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
# build/src/third_party/llvm-build-tools
# build/src/third_party/llvm-build
