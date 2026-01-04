#!/bin/bash
set -e -x
echo "6----------------------------------------------------------------"
mkdir -p build/src/out/Default
cp buildScript/ungoogled-chromium-debian-main/args.gn build/src/out/Default/args.gn
cd build/src
echo "7----------------------------------------------------------------"
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
patch -u tools/rust/build_bindgen.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/build_bindgen.patch
sed -i "s|RUST_REVISION = 'f8297e351a40c1439a467bbbb6879088047f50b3'|RUST_REVISION = 'ded5c06cf21d2b93bffd5d884aa6e96934ee4234'|g" "$WORKSPACE/build/src/tools/rust/update_rust.py"
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION
