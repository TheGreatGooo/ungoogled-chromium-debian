#!/bin/bash
set -e
git submodule update --init --recursive
rm -rf build/src build/domsubcache.tar.gz 
echo "1----------------------------------------------------------------"
mkdir -p build/download_cache
./utils/downloads.py retrieve -c build/download_cache -i downloads.ini
./utils/downloads.py unpack -c build/download_cache -i downloads.ini -- build/src
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
echo "6----------------------------------------------------------------"
popd
mkdir -p build/src/out/Default
cp buildScript/ungoogled-chromium-debian-main/args.gn build/src/out/Default/args.gn
cd build/src
echo "7----------------------------------------------------------------"
patch -u tools/clang/scripts/build.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/clang_build.patch 
tools/clang/scripts/build.py --host-cc /usr/bin/clang --host-cxx /usr/bin/clang++ --use-system-cmake --with-ml-inliner-model='' --without-android --without-fuchsia  
patch -u tools/rust/build_rust.py -i ../../buildScript/ungoogled-chromium-debian-main/patches/rust_build.patch
tools/rust/build_rust.py
echo "8----------------------------------------------------------------"
pushd third_party/node
./update_node_binaries
popd
echo "9----------------------------------------------------------------"
./out/Default/gn gen out/Default --fail-on-unused-args
echo "10----------------------------------------------------------------"
ninja -C out/Default chrome chromedriver chrome_sandbox
