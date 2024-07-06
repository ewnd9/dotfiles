#!/bin/bash

set -e

note_year=$(date -v -Mon '+%Y')
note_day=$(date -v -Mon '+%Y-%m-%d.md')

note_dir="$HOME/Dropbox/plan/retro/years/$note_year"
note_file="retro-$note_day"

mkdir -p "$note_dir"
code "$note_dir/$note_file"
