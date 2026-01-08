#!/bin/bash
set -ex
CLANG_PATH=$WORKSPACE/build/src/third_party/llvm-build/Release+Asserts/bin
export CC=$CLANG_PATH/clang
export CXX=$CLANG_PATH/clang++
export AR=$CLANG_PATH/llvm-ar
export NM=$CLANG_PATH/llvm-nm
cat "flags.gn" "buildScript/ungoogled-chromium-debian-main/args.gn" | tee "build/src/out/Default/args.gn"
cd build/src
echo "9----------------------------------------------------------------"
./out/Default/gn gen out/Default --fail-on-unused-args
