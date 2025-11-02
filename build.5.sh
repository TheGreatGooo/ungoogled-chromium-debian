#!/bin/bash
set -e
cd build/src
echo "9----------------------------------------------------------------"
./out/Default/gn gen out/Default --fail-on-unused-args
sed -i "s|../../linux/debian_bullseye_amd64-sysroot/|/|g" build/modules/linux-x64/module.modulemap
