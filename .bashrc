# DXist's .bashrc

# Source global definitions
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

# functions
. ~/.bash_functions

# local settings
if [ -r ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

export PATH=$HOME/bin:$PATH:
export EDITOR=`which vim`
# quit less if one output fits on one screen
export PAGER="less -FX"

# Git config
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true

export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

case "$TERM" in
  screen)
      set -o functrace
      trap 'echo -ne "\ek\$:${BASH_COMMAND:0:20}\e\\"' DEBUG
      export PS1='\[\033k$:\W\033\\\][\u@\h \W$(__git_ps1 " (%s)")]\$ '
    ;;
  *)
    ;;
esac

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
	if [ -r ~/.dir_colors ]; then
		eval `dircolors ~/.dir_colors`
	fi
fi

venvwrapper=`which virtualenvwrapper.sh`
if [ -r  "$venvwrapper" ]; then
	export WORKON_HOME=~/envs
	export PROJECT_HOME=~/workspace
	if [ -z "$VIRTUALENVWRAPPER_PYTHON" ]; then
		export VIRTUALENVWRAPPER_PYTHON=`which python`
	fi
	. $venvwrapper
fi

if [ -r /etc/bash_completion.d/git ]; then
	. /etc/bash_completion.d/git
fi

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias l='ls $LS_OPTIONS -lAhF'
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'

alias vi='vim'

