## basic
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias cc="cd && clear"
$ () {
  $@
}

## tmux
alias tmux="TERM=screen-256color tmux"
alias tt="tmux resize-pane -y 50"
alias tmux-reload="tmux source-file ~/.tmux.conf"
tmux-cd () {
  DIR=$(tmux display-message -p -F "#{pane_current_path}" -t {$1-of})
  cd $DIR
}
alias tml="tmux-cd left"
alias tmr="tmux-cd right"
alias tmu="tmux-cd up"
alias tmd="tmux-cd down"
zz() {
  tmux new-window -a -n $(echo $PWD | sed "s~$HOME/~~g")
}
zd() {
  DEST=$1
  tmux new-window -c $DEST -n $(echo $DEST | sed "s~$HOME/~~g")
}
zc() {
  tmux rename-window $(echo $PWD | sed "s~$HOME/~~g")
}


## git
alias c="git commit --message"
p() {
  git push -u origin $(git rev-parse --abbrev-ref HEAD) "$@"
}
alias pp="git remote | xargs -L1 git push --all"
alias pm="git push origin master"

alias gs="git status"
alias gss="git show"
alias gsg="git-stats --global-activity"
alias gsa="git-stats --authors"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias gasc="git log --patch --reverse"
alias gdesc="git log --patch"
alias gst="git stash"
alias gstp="git stash pop"
alias gll="bash ~/dotfiles/scripts/git-pretty-log.sh"

alias wip="git commit -a -m wip --no-verify"
alias amend="git commit -a --amend"

alias ga="git add ."
alias gca="git checkout ."
alias gra="git reset ."
alias gfo="git fetch --prune origin"
alias gri="git rebase -i"
alias gfr="git fetch origin && git rebase -i origin/master"
alias gfd="git fetch origin && git rebase -i origin/develop"
gfrc () {
  git fetch origin && git rebase -i origin/$(git rev-parse --abbrev-ref HEAD) "$@"
}
alias gfur="git fetch upstream && git rebase -i upstream/master"
alias gfrr="git rebase -i origin/master"
alias gfurr="git rebase -i upstream/master"
alias grc="git rebase --continue"
alias gpr="git pull --rebase --autostash"
alias gsu="git submodule update --init"
alias gst="git stash save --include-untracked"

alias gpo="git pull origin"
alias gpom="git pull origin master"

alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
gcbr () {
  gfo && git checkout -b "$1" "origin/$1"
}
alias gcl="git checkout -"
alias gcd="git checkout develop"

gt () {
  git tag -a "$@" -m "$@"
}

## apt/xclip
alias xc='xclip -selection clipboard'
alias xp='xclip -selection clipboard -o'

## print last n entries from history
xx () {
  N="${1:-1}"
  # LAST_COMMAND=$(fc -l -1 | head -n 1 | awk '{ print substr($0, index($0,$2)) }')
  LAST_COMMAND=$(fc -l -$N | awk '{ print substr($0, index($0,$2)) }')
  echo $LAST_COMMAND
  echo $LAST_COMMAND | xclip -selection clipboard
}

## network
alias serve="python -m SimpleHTTPServer"
alias curl-headers="curl -i"
alias curl-only-headers="curl -v -s 1> /dev/null"
alias curlj="curl -H 'Content-Type: application/json' -X POST --data"
alias myip="ifconfig | grep \"inet addr\""
port () { netstat -tulpn | grep :$1 }
killport () { fuser -k $1/tcp }

## processes
alias psme="ps -U ewnd9 | grep"

## text processing
todo () {
  DIR=${@:-.}
  rg --line-number --word-regexp 'FIXME|TODO' --context 1 --pretty "$DIR" "$@" | less -R
}
todoo () {
  DIR=${@:-.}
  rg --line-number --word-regexp 'FIXME|TODO' --context 1 --pretty "$DIR" "$@"
}
todoc () {
  DIR=${@:-.}
  rg --line-number --word-regexp 'FIXME|TODO' --context 1 --pretty --count "$DIR" | wc -l
}
todocc () {
  DIR=${@:-.}
  rg --line-number --word-regexp 'FIXME|TODO' --context 1 --pretty --count "$DIR" "$@"
}

alias grep-text="grep -nr"
alias find-file="find . -type f -name" # $ find-file '.*'
alias find-dir="find . -type d -name" # $ find-dir '*babel*'

## atom
a () {
  belt ewnd9:open-editor atom "$@"
}
## code
aa () {
  belt ewnd9:open-editor code-insiders "$@"
}

## system
# alias ls="ls --color=auto"
# alias rm="trash"
alias ll="ls -lh"
alias restore="echo '\u001b[?25h'"
alias cal="ncal -M -3"
alias k="awk '{print \$1}' | xargs kill"

## apt
alias i="sudo apt-get install"
alias upd="sudo apt-get update"
alias show-available-updates="sudo apt-get --just-print upgrade"

## npm
alias npo="npm --cache-min 9999999"
alias npr="cached-npm-repo"
alias nps="cat package.json | jq '.scripts'"
alias nbw="npm run build:watch"
alias lint="npm run lint -- --fix --cache"
alias tw="npm run test:watch"
alias bw="npm run build:watch"
## yarn
alias s="yarn start"
alias sd="yarn start:dev"
alias ss="yarn storybook"
alias yt="yarn test"
alias yts="yarn test:watch --"
alias yuii="yarn upgrade-interactive"
alias yui="yuii --latest"
alias yaw="yarn workspace"

## npm/mocha
alias mb="NODE_ENV=test mocha --require babel/register"

## npm/yo
alias glint="yo ewnd9-eslint"

## npm/jsonfui
# alias json="jsonfui"
alias json="python -m json.tool"

## npm/cached-npm-install
alias cni="cached-npm-install"

## npm/tldr
alias tldr="tldr --theme ocean"

## node
alias na="node --harmony-async-await"
alias nan="nodemon -x 'node --harmony-async-await'"
deps () {
  # Usage: $ npm install $(deps index.js)
  node -e "console.log(require('detect-import-require')(require('fs').readFileSync('$1', 'utf8')).filter(x => x[0] !== '.').join(' '))"
}
ts () {
  local target="${1/#\~/$HOME}"
  local parent_directory=$(dirname ${target})

  for i in {0..10}
  do
    ts_node_path=${parent_directory}/node_modules/.bin/ts-node

    if [[ -f $ts_node_path ]]
    then
      break
    fi

    parent_directory=$(realpath "${parent_directory}/..")
  done

  if [[ -z $ts_node_path ]];
  then
    echo "can't find node_modules/.bin/ts-node for ${target}"
  fi

  ${ts_node_path} --project "${parent_directory}/tsconfig.json" ${target}
}

## apt/wordnet
syns () { wordnet "$1" -syns{n,v,a,r} | less }

## git/gmusic-scripts
alias gmupload="python3 $HOME/misc/gmusicapi-scripts/gmusicapi_scripts/gmupload.py"

## github search
# g () {
#   input=$@
#   xdg-open "https://github.com/search?q=extension%3Ajs+$input&ref=searchresults&type=Code&utf8=%E2%9C%93"
# }
# gg () {
#   repo=$(npm view $1 homepage | sed 's/#readme//')
#   input=${@:2}
#   xdg-open "$repo/search?utf8=%E2%9C%93&q=$input"
# }

## docker
alias dm="docker-machine"
alias trydocker="docker run --rm -it -v $PWD:/app ubuntu:16.04 /bin/bash"

## python
alias py="python"
alias py3="python3"

## gcc
alias formatc="clang-format -i *.cpp"
alias runc="gcc main.cpp -o main && ./main"

## gui
alias psg="gnome-system-monitor"

## zsh
alias zshrc="cat ~/.zshrc | grep"
alias zsha="vim ~/.zsh/aliases.zsh && source ~/.zshrc"

## network
alias woff="$HOME/woff"
alias won="$HOME/won"

## ranger
alias ra="ranger"

## vim
alias vim="nvim"

## menu
alias e="$HOME/github/nodemenu/bin/nodemenu"

## memo
mem () {
  SUM=$(ps aux | grep $1 | grep -v grep | awk '{s+=$6} END {print s}')
  node -pe "require('pretty-bytes')(${SUM}000);"
}

## belt-cli
alias b="belt"

## fkill-cli (all common web ports)
alias kk="fkill :3000 ; fkill :3001 ; fkill :3010"

## shfmt
alias shf="shfmt -w -i 2 ."
