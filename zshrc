# Set up the prompt

source $HOME/.zsh/git-prompt/zshrc.sh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

git_super_status() {
  precmd_update_git_vars

  if [ -n "$__CURRENT_GIT_STATUS" ]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
    STATUS=" $STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    echo "$STATUS"
  fi
}

PROMPT='%F{yellow}%Bλ %~%b$(git_super_status)%f %# '

setopt histignorealldups sharehistory

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

fpath=(~/.zsh/completion $fpath)

# Use modern completion system
autoload -Uz compinit
compinit

# zstyle ':completion:*' menu select=2
# zstyle ":completion:*:descriptions" format "%B%d%b"
# zstyle ":completion:*:commands" rehash 1

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

eval "$(dircolors -b)"

##### ewnd9

synclient TapButton3=2

bindkey "^x" forward-word
bindkey "^[[1;5D" backward-word

function nginx-log {
  ssh -t $1 "sudo tail -f /var/log/nginx/$2.log"
}

function nginx-restart {
  ssh -t $1 "sudo service nginx restart"
}

## navigation
mkcd () { mkdir -p "$@" && cd "$@" }
mkcdn () { mkdir -p "$@" && cd "$@" && echo "'use strict';\n\n" > index.js && echo "{\"private\": true}" > package.json }

## apt/git
clone () {
  git clone $1 && \
  repo_name=$(echo $_ | sed -n -e 's/^.*\/\([^.]*\)\(.git\)*/\1/p') && \
  echo "cd $repo_name" && \
  cd "$repo_name"
}
clonea () {
  clone $1 && \
  atom .
}
alias commit="git commit -a -m"
alias push="git push origin master"

## apt/xclip
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

## network
app-port () { lsof -n -i4TCP:$1 }
alias serve="python -m SimpleHTTPServer"
alias curl-headers="curl -i"
alias curl-only-headers="curl -v -s 1> /dev/null"
alias myip="ifconfig | grep \"inet addr\""

## web
web-screen () {
  dir="/tmp/$(date "+%m-%d-%Y-%H-%M")"
  mkcd $dir
  pageres 320x534 800x1280 1360x768 1920x1080 $@ --verbose
  nemo .
  cd -
}

## processes
alias psme="ps -U ewnd9 | grep"

## text processing
alias grep-text="grep -nr"
alias find-me="find . -type f -name"
alias cap-logs="ruby $HOME/dotfiles/scripts/capistrano-remote-logs.rb"

## atom
alias a="atom ."
acd () { cd "$@" && atom . }

## system
alias sus="sudo pm-suspend"
alias ls="ls --color=auto"
alias rm="trash"
alias ll="ls -lh"
alias restore="echo \"process.stdout.write('\u001b[?25h');\" | node"
c () { cat "$@" | less }
t () { tail -f "$@" }

## apt
alias i="sudo apt-get install"
alias upd="sudo apt-get update"
alias show-available-updates="sudo apt-get --just-print upgrade"

## npm
alias npm="$HOME/dotfiles/scripts/npm-alias"
alias npo="npm --cache-min 9999999"
alias npr="cached-npm-repo"
alias nbw="npm run build:watch"
npmjs () { xdg-open http://npmjs.com/package/$1 }
x () { node_modules/.bin/"$@" }
v () { cat $(node -e "console.log(require('pkg-up').sync(require.resolve('$1')))") | grep version }

## npm/dictionary-cli
alias d="dictionary --ru=en"
alias в="dictionary --ru=en"

## npm/mocha
alias mb="NODE_ENV=test mocha --require babel/register"

## npm/yo
alias glint="yo ewnd9-eslint"
glib () {
  yo ewnd9-npm && \
  yo ewnd9-eslint && \
  cached-npm-install && \
  git init && \
  git add . && \
  git commit -a -m "boilerplate" && \
  node ./node_modules/husky/bin/install.js && \
  atom .
}

## npm/pw3 npm/trakt-cli
shows () { pw3 "$(trakt --available --json)" }

## npm/jsonfui
alias json="jsonfui"

## npm/cached-npm-install
alias cni="cached-npm-install"

## npm/n
npm-n-path-prefix () { echo "$HOME/n/n/versions/node/$1" }
npm-n-path-node () { echo "$(npm-n-path-prefix $1)/bin/node" }
npm-n-path-npm () { echo "$(npm-n-path-prefix $1)/lib/node_modules/npm/cli.js" }
node-10 () { $(npm-n-path-node 0.10.36) $@ }
npm-10 () { $(npm-n-path-npm 0.10.36) $@ }

## github/ErrorBoard2
error-board () { cd ~/misc/ErrorBoard2 && npm start }

## apt/wordnet
syns () { wordnet "$1" -syns{n,v,a,r} | less }

## apt/figlet
alias note="figlet"

## git/gmusic-scripts
alias gmupload="python3 $HOME/misc/gmusicapi-scripts/gmusicapi_scripts/gmupload.py"

## github search
g () {
  input=$@
  xdg-open "https://github.com/search?q=extension%3Ajs+$input&ref=searchresults&type=Code&utf8=%E2%9C%93"
}
gg () {
  repo=$(npm view $1 homepage | sed 's/#readme//')
  input=${@:2}
  xdg-open "$repo/search?utf8=%E2%9C%93&q=$input"
}

## zsh
alias zshrc="cat ~/.zshrc | grep"

weather () { curl wttr.in/$1 }

export EDITOR=vim

export ANDROID_HOME="$HOME/soft/android-sdk"
export NODE_PATH=$NODE_PATH:$HOME/.npm-packages/lib/node_modules
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"

export LC_TIME=en_US.UTF-8

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/soft/android-sdk/tools:$PATH"
export PATH="$HOME/soft/android-sdk/platform-tools:$PATH"
export PATH="$PATH:$HOME/.npm-packages/bin"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"

export N_PREFIX=$HOME/n

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
