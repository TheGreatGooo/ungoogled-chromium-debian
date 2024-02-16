mkdir -p chromePackage
cd chromePackage
cp ../build/src/out/Default/* . || true
cp -R ../build/src/out/Default/angledata .
cp -R ../build/src/out/Default/locales .
cp -R ../build/src/out/Default/resources .
rm -rf .ninja_deps .ninja_log build.ninja