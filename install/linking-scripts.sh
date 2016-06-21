#!/bin/bash

if [[ $1 == "--apply" ]]; then
  APPLY=true
  echo -e "applying\n"
else
  APPLY=false
fi

function log_and_exec {
  cmd=$1
  echo $cmd

  if [[ $APPLY = true ]]; then
    echo "applying"
    $(cmd)
  fi
}

function link {
  file=$1

  echo -e "$file\n"
  script=$(basename $file | cut -d. -f1)

  if [[ -a /usr/bin/$script ]]; then
    i=""

    while true; do
      if [[ $i == "" ]]; then
        replacement="$script-old"
        i=0
      else
        replacement="$script-old-$i"
        i=$(($i + 1))
      fi

      if [[ ! -a /usr/bin/$replacement ]]; then
        break
      fi
    done

    log_and_exec "sudo mv /usr/bin/$script /usr/bin/$replacement"
  fi

  log_and_exec "sudo ln -s $file /usr/bin/$script"
  echo -e ""
}

DIRS=(
  $HOME/dotfiles/scripts
  $HOME/dotfiles/scripts/asus
  $HOME/dotfiles/scripts/tmux
  $HOME/dotfiles/scripts/wm
)

for dir in ${DIRS[@]}; do
  find $dir -maxdepth 1 -type f | while read file; do
    link $file
  done
done
