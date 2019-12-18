#!/bin/bash
set -e

VERSION="v2.8.0"
URL="https://github.com/florindumitru/react-native-pjsip-builder/archive/${VERSION}.tar.gz"
LOCK=".libs.lock"
DEST=".libs.tar.gz"
DOWNLOAD=true

if ! type "curl" > /dev/null; then
    echo "Missed curl dependency" >&2;
    exit 1;
fi
if ! type "tar" > /dev/null; then
    echo "Missed tar dependency" >&2;
    exit 1;
fi

if [ -f ${LOCK} ]; then
    CURRENT_VERSION=$(cat ${LOCK})

    if [ "${CURRENT_VERSION}" == "${VERSION}" ];then
        DOWNLOAD=false
    fi
fi

if [ "$DOWNLOAD" = true ]; then
    curl -L --silent "${URL}" -o "${DEST}"
    tar -xvf "${DEST}"
    rm -f "${DEST}"

    echo "${VERSION}" > ${LOCK}
    cd react-native-pjsip-builder-2.8.0
    ./release.sh
    cp -rf dist/ios/VialerPJSIP.framework ../ios/
    cp -rf dist/android/src/* ../android/src
fi
