# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="regularfry"



# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...
export LC_CTYPE=

setopt clobber
#export LC_CTYPE=en_GB.UTF-8
export LC_CTYPE=

alias screen='echo $SSH_AUTH_SOCK > ~/.ssh_auth_sock && screen'
alias sync_ssh='export SSH_AUTH_SOCK=`cat ~/.ssh_auth_sock`'
alias ec="emacsclient -n"
alias rtest="ruby -I.:lib:tests/unit -rpp -rubygems"
alias trails="ruby -I.:lib:test -rpp -rubygems"
alias openvpn="sudo /etc/init.d/openvpn"
alias be="bundle exec"
alias ebe="env/bin/exec"

export EDITOR=vim

export CHICKEN_BIN=$HOME/.chicken/bin
export CABAL_BIN=$HOME/.cabal/bin
export CLJR_BIN=/home/zander/.cljr/bin

export PATH=$CLJR_BIN:$CHICKEN_BIN:$HOME/bin:$CABAL_BIN:$PATH

if [ -e $SSH_AUTH_SOCK ]; then
  if ! ssh-add -L > /dev/null; then
    ssh-add
  fi
fi

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOPATHS=$GOPATH/bin:$GOROOT/bin
export PATH=$CHICKEN_BIN:$HOME/bin:$HOME/.gem/ruby/1.8/bin:$GOPATHS:$PATH
export DEBEMAIL=alex@blackkettle.org
export DEBFULLNAME="Alex Young"
#source $HOME/.rvm/scripts/rvm

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function pyactivate(){
  source $1/bin/activate
  export PATH=$1/bin:$PATH
}

source /usr/share/chruby/chruby.sh
