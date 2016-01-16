#!/bin/sh

tag=$(($1 - 1))
wmctrl -s $tag
