#!/bin/sh

set -e

path="$1"

if [ -d "$path" ]
then
	echo "$(cd "$path" ; pwd)"
else
	b=$(basename "$path")
	p=$(dirname "$path")
	echo "$(cd "$p" ; pwd)/$b"
fi
