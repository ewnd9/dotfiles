## git
alias commit="git commit -a -m"
alias push="git push origin master"

## apt/xclip
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

## network
alias serve="python -m SimpleHTTPServer"
alias curl-headers="curl -i"
alias curl-only-headers="curl -v -s 1> /dev/null"
alias myip="ifconfig | grep \"inet addr\""

## processes
alias psme="ps -U ewnd9 | grep"

## text processing
alias grep-text="grep -nr"
alias find-me="find . -type f -name"
alias cap-logs="ruby $HOME/dotfiles/scripts/capistrano-remote-logs.rb"

## atom
alias a="atom ."

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
alias nbw="npm run build:watch"
alias lint="npm run lint -- --fix"

## npm/dictionary-cli
alias d="dictionary --ru=en"
alias в="dictionary --ru=en"

## npm/mocha
alias mb="NODE_ENV=test mocha --require babel/register"

## npm/yo
alias glint="yo ewnd9-eslint"

## npm/jsonfui
# alias json="jsonfui"
alias json="python -m json.tool"

## npm/cached-npm-install
alias cni="cached-npm-install"

## npm/n
npm-n-path-prefix () { echo "$HOME/n/n/versions/node/$1" }
npm-n-path-node () { echo "$(npm-n-path-prefix $1)/bin/node" }
npm-n-path-npm () { echo "$(npm-n-path-prefix $1)/lib/node_modules/npm/cli.js" }
node-10 () { $(npm-n-path-node 0.10.36) $@ }
npm-10 () { $(npm-n-path-npm 0.10.36) $@ }
node-6 () { $(npm-n-path-node 6.0.0) $@ }
npm-6 () { $(npm-n-path-npm 6.0.0) $@ }

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
# gg () {
#   repo=$(npm view $1 homepage | sed 's/#readme//')
#   input=${@:2}
#   xdg-open "$repo/search?utf8=%E2%9C%93&q=$input"
# }

## zsh
alias zshrc="cat ~/.zshrc | grep"
