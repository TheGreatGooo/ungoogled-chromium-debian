#!/bin/bash
set -ex
pushd build/src
sed -i "s|RUST_REVISION = 'f8297e351a40c1439a467bbbb6879088047f50b3'|RUST_REVISION = 'ded5c06cf21d2b93bffd5d884aa6e96934ee4234'|g" "$WORKSPACE/build/src/tools/rust/update_rust.py"
sed -i "s|CLANG_REVISION = 'llvmorg-22-init-8940-g4d4cb757'|CLANG_REVISION = '6d31e7e4f29e89213a55e9f5fdcd176396604637'|g" "$WORKSPACE/build/src/tools/clang/scripts/update.py"
sed -i "s|GitCherryPick(LLVM_DIR|#GitCherryPick(LLVM_DIR|g" "$WORKSPACE/build/src/tools/clang/scripts/build.py"
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
patch -u tools/rust/build_bindgen.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/build_bindgen.patch
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION