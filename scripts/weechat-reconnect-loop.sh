#!/bin/sh

while true; do
  ssh -t pi@rp "screen -x"
  sleep 10
done
