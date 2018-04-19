#!/bin/sh

# https://github.com/karlhorky/command-line-tricks/blob/master/gzip-web-assets.sh

rm -rf gzipped
mkdir gzipped

for file in $(find . -type f | egrep "\.(css|js|eot|svg|ttf)$") ; do
  gzip -c --best "$file" > "gzipped/$file"
done
