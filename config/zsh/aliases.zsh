## basic
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias cc="cd && clear"

## tmux
alias tt="tmux resize-pane -y 50"
tmux-cd () {
  DIR=$(tmux display-message -p -F "#{pane_current_path}" -t {$1-of})
  cd $DIR
}
alias tml="tmux-cd left"
alias tmr="tmux-cd right"
alias tmu="tmux-cd up"
alias tmd="tmux-cd down"

## git
alias st="git status"
alias com="git commit"
alias commit="git commit -a -m"
alias push="git push origin master"
alias wip="git commit -a -m wip --no-verify"
alias amend="git commit -a --amend --no-verify"
alias rebac="git rebase --continue"

## apt/xclip
alias xc='xclip -selection clipboard'
alias xp='xclip -selection clipboard -o'
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
alias myip="ifconfig | grep \"inet addr\""
port () { netstat -tulpn | grep :$1 }
killport () { fuser -k $1/tcp }

## processes
alias psme="ps -U ewnd9 | grep"

## text processing
alias grep-text="grep -nr"
alias find-file="find . -type f -name" # $ find-file '.*'
alias find-dir="find . -type d -name" # $ find-dir '*babel*' 

## atom
a () {
  DEST_TAG="1"
  COUNT=$(wmctrl -l | awk '{print $2}' | grep 1 | wc -l)

  if [ $COUNT -gt 0 ]; then
    DEST_TAG="3"  
  fi

  echo $DEST_TAG
  wmctrl -s $DEST_TAG
  atom .
}

## system
alias sus="sudo pm-suspend"
alias ls="ls --color=auto"
alias rm="trash"
alias ll="ls -lh"
alias restore="echo '\u001b[?25h'"

## apt
alias i="sudo apt-get install"
alias upd="sudo apt-get update"
alias show-available-updates="sudo apt-get --just-print upgrade"

## npm
alias npm="$HOME/dotfiles/scripts/npm-alias"
alias npo="npm --cache-min 9999999"
alias npr="cached-npm-repo"
alias nps="cat package.json | jq '.scripts'"
alias nbw="npm run build:watch"
alias lint="npm --yarn run lint -- --fix"
alias tw="npm run test:watch"
alias bw="npm run build:watch"

## npm/mocha
alias mb="NODE_ENV=test mocha --require babel/register"

## npm/yo
alias glint="yo ewnd9-eslint"

## npm/jsonfui
# alias json="jsonfui"
alias json="python -m json.tool"

## npm/cached-npm-install
alias cni="cached-npm-install"

## node
alias na="node --harmony-async-await" 
alias nan="nodemon -x 'node --harmony-async-await'"

## apt/wordnet
syns () { wordnet "$1" -syns{n,v,a,r} | less }

## git/gmusic-scripts
alias gmupload="python3 $HOME/misc/gmusicapi-scripts/gmusicapi_scripts/gmupload.py"

## github search
g () {
  input=$@
  xdg-open "https://github.com/search?q=extension%3Ajs+$input&ref=searchresults&type=Code&utf8=%E2%9C%93"
}
# gg () {
#   repo=$(npm view $1 homepage | sed 's/#readme//')
#   input=${@:2}
#   xdg-open "$repo/search?utf8=%E2%9C%93&q=$input"
# }

## zsh
alias zshrc="cat ~/.zshrc | grep"
alias zsha="vim ~/.zsh/aliases.zsh && source ~/.zshrc"
