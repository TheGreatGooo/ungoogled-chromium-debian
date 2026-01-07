#!/bin/bash
set -ex
echo "2----------------------------------------------------------------"
./utils/prune_binaries.py build/src pruning.list
echo "3----------------------------------------------------------------"
./utils/patches.py apply build/src patches
echo "4----------------------------------------------------------------"
./utils/domain_substitution.py apply -r domain_regex.list -f domain_substitution.list -c build/domsubcache.tar.gz build/src
echo "5----------------------------------------------------------------"
mkdir -p build/src/out/Default
pushd build/src
./tools/gn/bootstrap/bootstrap.py --skip-generate-buildfiles -j4 -o out/Default/

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
