#!/bin/bash
set -ex
git submodule update --init --recursive
rm -rf build/src build/domsubcache.tar.gz 
echo "1----------------------------------------------------------------"
mkdir -p build/download_cache
./utils/downloads.py retrieve -c build/download_cache -i downloads.ini
./utils/downloads.py unpack -c build/download_cache -i downloads.ini -- build/src
