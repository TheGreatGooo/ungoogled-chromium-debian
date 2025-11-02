#!/bin/bash
mkdir -p chromePackage
cd chromePackage
cp ../build/src/out/Default/chrome .
cp ../build/src/out/Default/chromedriver .
cp ../build/src/out/Default/chrome_sandbox .
cp ../build/src/out/Default/chrome-wrapper .
cp -r ../build/src/out/Default/locales .
cp ../build/src/out/Default/*.bin .
cp ../build/src/out/Default/*.so .
cp ../build/src/out/Default/*.pak .
cp ../build/src/out/Default/*.dat .
