#!/bin/bash
set -e -x
echo "6----------------------------------------------------------------"
mkdir -p build/src/out/Default
cp buildScript/ungoogled-chromium-debian-main/args.gn build/src/out/Default/args.gn
cd build/src
echo "7----------------------------------------------------------------"
pushd $WORKSPACE/build/src/build/linux/sysroot_scripts
python3 -m venv .venv
source .venv/bin/activate
pip3 install requests
./generate_keyring.sh
python3 sysroot_creator.py build amd64
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
mkdir -p $LLVM_BUILD_TOOLS_DIR
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_amd64_sysroot"
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src/out/sysroot-build/bullseye/debian_bullseye_amd64_sysroot.tar.xz"
echo "dec7a3a0fc5b83b909cba1b6d119077e0429a138eadef6bf5a0f2e03b1904631" >> "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd
popd
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
patch -u tools/rust/build_bindgen.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/build_bindgen.patch
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION
