#!/bin/bash
set -e
echo "6----------------------------------------------------------------"
mkdir -p build/src/out/Default
cp buildScript/ungoogled-chromium-debian-main/args.gn build/src/out/Default/args.gn
cd build/src
echo "7----------------------------------------------------------------"
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
patch -u tools/rust/build_bindgen.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/build_bindgen.patch
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION
