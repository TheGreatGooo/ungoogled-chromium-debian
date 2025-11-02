#!/bin/bash
set -e
cd build/src
echo "10----------------------------------------------------------------"
ninja -C out/Default chrome chromedriver chrome_sandbox
