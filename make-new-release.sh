#!/usr/bin/env bash

set -euxo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION="$1"
DATE=$(date -u -I)
METAFILE="io.github.imputnet.helium-chromium.metainfo.xml"
COMMIT_MSG="update helium chromium to ${VERSION}"

sed -i "/<releases>/a \\
    <release version=\"${VERSION}\" date=\"${DATE}\" />" "${METAFILE}"
git add "${METAFILE}"
git commit -sm "${COMMIT_MSG}"
