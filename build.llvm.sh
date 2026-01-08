#!/bin/bash
set -ex
pushd build/src
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
# build/src/third_party/llvm-build-tools
# build/src/third_party/llvm-build
popd
