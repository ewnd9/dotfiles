#!/bin/bash

SRC="$1"
DEST="$2"
fn () {
	svgexport "$1" "$2$3.png" "$3:$3"
}

fn "$SRC" "$DEST" 16 
fn "$SRC" "$DEST" 48
fn "$SRC" "$DEST" 128
