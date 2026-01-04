#!/bin/bash
set -ex
pushd build/src
tools/rust/build_rust.py --skip-test
tools/rust/build_bindgen.py
cp third_party/rust-toolchain/VERSION third_party/rust-toolchain/INSTALLED_VERSION