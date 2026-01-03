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

ARCH="amd64"
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/sysroots/archive/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "dec7a3a0fc5b83b909cba1b6d119077e0429a138eadef6bf5a0f2e03b1904631" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="i386"
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/sysroots/archive/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "b53933120bb08ffc38140a817e3f0f99782254a6bf9622271574fa004e8783a4" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="armhf"
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_arm_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/sysroots/archive/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "fe81e7114b97440262bce004caf02c1514732e2fa7f99693b2836932ad1c4626" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="arm64"
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/sysroots/archive/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "308e23faba3174bd01accfe358467b8a40fad4db4c49ef629da30219f65a275f" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="riscv64"
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_trixie_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/sysroots/archive/build/src.riscv64/out/sysroot-build/trixie/debian_trixie_${ARCH}_sysroot.tar.xz"
echo "6c924a8f88bb4731f3c2334c6ae5b5da47d5ca196ff571a91071f104dbacecad" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd


popd
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
patch -u tools/rust/build_bindgen.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/build_bindgen.patch
sed -i "s|CLANG_REVISION = 'llvmorg-22-init-8940-g4d4cb757'|CLANG_REVISION = '292dc2b86f66e39f4b85ec8b185fd8b60f5213ce'|g" "$WORKSPACE/build/src/tools/clang/scripts/update.py"
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
sed -i "s|RUST_REVISION = 'f8297e351a40c1439a467bbbb6879088047f50b3'|RUST_REVISION = 'ded5c06cf21d2b93bffd5d884aa6e96934ee4234'|g" "$WORKSPACE/build/src/tools/rust/update_rust.py"
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION
