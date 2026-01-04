#!/bin/bash
set -ex
cd build/src
echo "10----------------------------------------------------------------"
ninja -C out/Default chrome chromedriver chrome_sandbox
