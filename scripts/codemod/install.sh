#!/bin/sh

for i in $(ls); do
  if [ -d "$i" ]
  then
    echo $i
    
    cd $i
    npm i --production
    cd -
  fi
done
