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

setopt clobber
unsetopt correct_all
source $HOME/.shell

function pyactivate(){
  source $1/bin/activate
  export PATH=$1/bin:$PATH
}

alias ec="emacsclient -n"

function resource(){
  source ~/.zshrc
}

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
export PATH="/usr/local/opt/openjdk/bin:$PATH"

eval "$(pyenv init -)"
