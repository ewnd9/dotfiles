#!/bin/bash

set -e 

if [ "$#" -ne 2 ]; then
	echo "Usage: \"\$ link <src> <dst>\""
	exit 1
fi

NORMAL_SRC="$(canonical-path "$1")"
NORMAL_DST="$(canonical-path "$2")"

if [ -a "$NORMAL_SRC" ]
then
	echo "${NORMAL_SRC}" "${NORMAL_DST}"
	ln -s "${NORMAL_SRC}" "${NORMAL_DST}"
else
	echo "\"${NORMAL_SRC}\" doesn't exist"
	exit 1
fi

