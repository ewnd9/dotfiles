#!/bin/bash

QUERY=$(xclip -out -selection primary)
xdg-open "$QUERY"
