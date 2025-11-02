#!/bin/bash
set -e
cat "flags.gn" "buildScript/ungoogled-chromium-debian-main/args.gn" | tee "build/src/out/Default/args.gn"
cd build/src
echo "9----------------------------------------------------------------"
./out/Default/gn gen out/Default --fail-on-unused-args
