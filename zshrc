# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

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

# ewnd9

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

function nginx-log {
  ssh -t $2 "sudo tail -f /var/log/nginx/$1.log"
}

function nginx-restart {
  ssh -t $1 "sudo service nginx restart"
}

function psql-remote {
  ssh -t $2 "psql -U admin -h localhost $1"
}

function psql-clone {
  ssh $2 "pg_dump -U admin -h localhost $1 > ~/1.sql"
  scp $2:~/1.sql .
  
  dropdb -U admin -h localhost $1
  createdb -U admin -h localhost $1
  
  psql -U admin -h localhost $1 < 1.sql
}

synclient TapButton3=2

alias ls="ls --color=auto"

alias psme="ps -U ewnd9 | grep $1"

function psme9 {
  pid=$(psme $1)
  echo $pid
}
alias psme91="kill -9 psme $1 | awk '{print $1}'"
alias findme="find . -type f -name $1"
alias cap-logs="ruby /home/ewnd9/dotfiles/scripts/capistrano-remote-logs.rb"
alias serve="python -m SimpleHTTPServer"
alias sus="sudo pm-suspend"
alias tx="/home/ewnd9/.rbenv/versions/2.1.5/bin/tmuxinator"
alias term="terminator --command=\"tmux\""

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export ANDROID_HOME="$HOME/soft/android-sdk"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export PATH="$HOME/soft/android-sdk/tools:$PATH"
export PATH="$HOME/soft/android-sdk/platform-tools:$PATH"
export PATH="$PATH:$HOME/.npm-packages/bin"
export EDITOR=vim
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
