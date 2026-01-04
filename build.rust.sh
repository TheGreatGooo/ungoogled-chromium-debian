#!/bin/bash
set -ex
pushd build/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKSPACE/build/src/third_party/llvm-build-tools/debian_bullseye_amd64_sysroot/usr/lib/x86_64-linux-gnu
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION
# build/src/third_party/rust-toolchain