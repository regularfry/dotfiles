# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='$(if [[ $? != 0 ]]; then echo "\[\033[00;31m\]FAIL\n\[\033[00m\]"; fi)\n[\t] \[\033[01;32m\]\u@\h \[\033[00m\]\[\033[01;34m\]\w \[\033[00;33m\]$(vcinfo)$(if [[ ! -z "${VIRTUAL_ENV}" ]]; then echo " [${VIRTUAL_ENV}]"; fi)\n\[\033[00m\]  \$ '
else
    PS1='[\t] \u@\h \w\n  \$ '
fi
unset color_prompt force_color_prompt

function title {
    PROMPT_COMMAND="echo -ne \"\033]0;$1\007\""
}

function prt {
    title $(basename $(pwd))
}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    title "${PWD/$HOME/~}"
    ;;
*)
    ;;
esac


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export PATH=$PATH:$HOME/bin
alias screen='echo $SSH_AUTH_SOCK > ~/.ssh_auth_sock && screen'
alias sync_ssh='export SSH_AUTH_SOCK=`cat ~/.ssh_auth_sock`'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f $HOME/.shell ]; then
  source $HOME/.shell
fi

if [ -e /usr/share/chruby/chruby.sh ]; then
  source /usr/share/chruby/chruby.sh
fi

if [ -e /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
