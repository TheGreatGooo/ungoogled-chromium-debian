#!/bin/bash
set -ex
cd build/src
CLANG_PATH=$WORKSPACE/build/src/third_party/llvm-build/Release+Asserts/bin
export CC=$CLANG_PATH/clang
export CXX=$CLANG_PATH/clang++
export AR=$CLANG_PATH/llvm-ar
export NM=$CLANG_PATH/llvm-nm
echo "10----------------------------------------------------------------"
ninja -C out/Default chrome chromedriver chrome_sandbox
