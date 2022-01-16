ROOT="/c/mozilla-source/mozilla-unified"
DIST="/c/jenkins/workspace/firefox-win/dist"

mkdir -p ${DIST}

cd ${ROOT} && ./mach --no-interactive package
cp ${ROOT}/obj-x86_64-pc-mingw32/dist/firefox*.zip ${DIST}/
