#!/bin/bash

VERSION=$1
echo "Changing this node version to ${VERSION}"
git fetch origin
git checkout ${VERSION}
sed -i 's,IMAGE_TAG=.*,IMAGE_TAG='"${VERSION}"',' .env

