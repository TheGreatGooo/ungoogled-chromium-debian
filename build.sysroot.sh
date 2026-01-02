mkdir -p build/src
pushd build/src
#wget https://chromium.googlesource.com/chromium/src/+archive/a98fe8c2f2e7c84dc95879fbc5a11f5de7662353.tar.gz
tar xvzf a98fe8c2f2e7c84dc95879fbc5a11f5de7662353.tar.gz

pushd $WORKSPACE/build/src/build/linux/sysroot_scripts
python3 -m venv .venv
source .venv/bin/activate
pip3 install requests

ARCH="amd64"
python3 sysroot_creator.py build $ARCH
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "dec7a3a0fc5b83b909cba1b6d119077e0429a138eadef6bf5a0f2e03b1904631" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="i386"
python3 sysroot_creator.py build $ARCH
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "b53933120bb08ffc38140a817e3f0f99782254a6bf9622271574fa004e8783a4" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="armhf"
python3 sysroot_creator.py build $ARCH
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_arm_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "fe81e7114b97440262bce004caf02c1514732e2fa7f99693b2836932ad1c4626" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

ARCH="arm64"
python3 sysroot_creator.py build $ARCH
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_bullseye_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src/out/sysroot-build/bullseye/debian_bullseye_${ARCH}_sysroot.tar.xz"
echo "308e23faba3174bd01accfe358467b8a40fad4db4c49ef629da30219f65a275f" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd

mkdir -p $WORKSPACE/build/src.riscv64
pushd $WORKSPACE/build/src.riscv64
wget https://chromium.googlesource.com/chromium/src/+archive/7cc2fd642bdcee70fc21d8a0f9e01cfa26624e94.tar.gz
tar xvzf 7cc2fd642bdcee70fc21d8a0f9e01cfa26624e94.tar.gz

pushd $WORKSPACE/build/src.riscv64/build/linux/sysroot_scripts
python3 -m venv .venv
source .venv/bin/activate
pip3 install requests

ARCH="riscv64"
python3 sysroot_creator.py build $ARCH
LLVM_BUILD_TOOLS_DIR="$WORKSPACE/build/src.riscv64/third_party/llvm-build-tools"
DEBIAN_SYSROOT_EXPECTED="$LLVM_BUILD_TOOLS_DIR/debian_trixie_${ARCH}_sysroot"
mkdir -p $DEBIAN_SYSROOT_EXPECTED
pushd $DEBIAN_SYSROOT_EXPECTED
tar xvf "$WORKSPACE/build/src.riscv64/out/sysroot-build/trixie/debian_trixie_${ARCH}_sysroot.tar.xz"
echo "6c924a8f88bb4731f3c2334c6ae5b5da47d5ca196ff571a91071f104dbacecad" > "$DEBIAN_SYSROOT_EXPECTED/stamp"
popd
