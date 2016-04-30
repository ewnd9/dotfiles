#!/bin/bash

set -e

if [ $# == 0 ] ; then
	echo "git-tag <version>"
	exit 1
fi

VERSION="v$1"
git commit -a -m "release $VERSION" --allow-empty
git tag -a "$VERSION" -m "$VERSION"

