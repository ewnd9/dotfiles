#!/bin/bash

if test "$#" -ne 1; 
then
	DEST=$2
else
	DEST=$1
fi

sudo ln -s $(pwd)/$1 /usr/bin/$DEST

echo "linked $(pwd)/$1 -> /usr/bin/$DEST"

