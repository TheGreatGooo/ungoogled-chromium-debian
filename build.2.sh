#!/bin/bash
set -e
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
