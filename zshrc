# Set up the prompt

source /home/ewnd9/dotfiles/config/zsh/zsh-git-prompt/zshrc.sh

git_super_status() {
	precmd_update_git_vars
  
	if [ -n "$__CURRENT_GIT_STATUS" ]; then
	  STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
	  STATUS=" $STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
	  echo "$STATUS"
	fi
}

PROMPT='%F{yellow}%B%n@%m %~%b$(git_super_status)%f %# '

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
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

##### ewnd9

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

function nginx-log {
  ssh -t $1 "sudo tail -f /var/log/nginx/$2.log"
}

function nginx-restart {
  ssh -t $1 "sudo service nginx restart"
}

function psql-remote {
  ssh -t $1 "psql -U admin -h localhost $2"
}

function psql-clone {
  ssh $1 "pg_dump -U admin -h localhost $2 > ~/1.sql"
  scp $1:~/1.sql .
  
  dropdb -U admin -h localhost $2
  createdb -U admin -h localhost $2
  
  psql -U admin -h localhost $2 < 1.sql
}

function mkcd {
	mkdir -p "$@" && cd "$@"
}

function clone {
  git clone $1
  repo_name=$(echo $_ | sed -n -e 's/^.*\/\([^.]*\)\(.git\)*/\1/p')
  echo "cd $repo_name"
  cd "$repo_name"
}

function human-space {
	du -sh $1
}

function app-port {
	lsof -n -i4TCP:$1
}

synclient TapButton3=2

alias ls="ls --color=auto"

alias psme="ps -U ewnd9 | grep $1"

alias findme="find . -type f -name $1"
alias cap-logs="ruby /home/ewnd9/dotfiles/scripts/capistrano-remote-logs.rb"
alias serve="python -m SimpleHTTPServer"
alias sus="sudo pm-suspend"
alias tx="/home/ewnd9/.rbenv/versions/2.1.5/bin/tmuxinator"
alias term="terminator --command="tmux""

alias wds="webpack-dev-server"
alias br="sudo brightness"
alias bn="babel-node"
alias w="watchtower"
alias yt="yandex-translate"
alias d="dictionary"
alias a="atom ."
alias gif="ttystudio output.gif --log && eog output.gif"

alias human-space="du -sh $1"
alias grep-text="grep -nr "$1" $2"
alias curl-headers="curl -i"
alias curl-only-headers="curl -v -s 1> /dev/null"

function open-chrome-extension {
echo $@
cd "/home/ewnd9/.config/google-chrome/Default/Extensions/$1"
}

alias npm-publish="npm version $1 && git push origin master && git push origin --tags && npm publish"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

export ANDROID_HOME="$HOME/soft/android-sdk"
export NODE_PATH=$NODE_PATH:/home/ewnd9/.npm-packages/lib/node_modules
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export PATH="$HOME/soft/android-sdk/tools:$PATH"
export PATH="$HOME/soft/android-sdk/platform-tools:$PATH"
export PATH="$PATH:$HOME/.npm-packages/bin"
export EDITOR=vim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
