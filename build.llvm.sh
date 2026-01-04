#!/bin/bash
set -e
pushd build/src
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
sed -i "s|CLANG_REVISION = 'llvmorg-22-init-8940-g4d4cb757'|CLANG_REVISION = '8e2cd28cd4ba46613a46467b0c91b1cabead26cd'|g" "$WORKSPACE/build/src/tools/clang/scripts/update.py"
sed -i "s|GitCherryPick(LLVM_DIR|#GitCherryPick(LLVM_DIR|g" "$WORKSPACE/build/src/tools/clang/scripts/build.py"
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
# build/src/third_party/llvm-build-tools
# build/src/third_party/llvm-build
