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

export LANG="ru_RU.UTF-8"
export LC_CTYPE="ru_RU.UTF-8"
export LC_NUMERIC="ru_RU.UTF-8"
export LC_TIME="ru_RU.UTF-8"
export LC_COLLATE="ru_RU.UTF-8"
export LC_MONETARY="ru_RU.UTF-8"
export LC_MESSAGES="C"
export LC_PAPER="ru_RU.UTF-8"
export LC_NAME="ru_RU.UTF-8"
export LC_ADDRESS="ru_RU.UTF-8"
export LC_TELEPHONE="ru_RU.UTF-8"
export LC_MEASUREMENT="ru_RU.UTF-8"
export LC_IDENTIFICATION="ru_RU.UTF-8"

if [[ "${PATH}" != *$HOME/bin* ]]; then
	export PATH=$HOME/bin:$PATH
fi

export EDITOR=`which vim`
# quit less if one output fits on one screen
export PAGER="less -FX"
export LESSOPEN="|pygmentize -g -O encoding=utf-8 %s"

# Git config
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true

export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
	if [ -r ~/.dir_colors ]; then
		eval `dircolors ~/.dir_colors`
	fi
fi

if [[ "${GOPATH}" != *$HOME/goworkspace* ]]; then
	export GOPATH=$GOPATH:$HOME/goworkspace
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

if [ -z "$TMUX" ]; then
    # we're not in a tmux session

	# Predictable SSH authentication socket location.
	SOCK="/tmp/ssh-agent-$USER-tmux"
	if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
	then
		rm -f $SOCK
		ln -sf $SSH_AUTH_SOCK $SOCK
		export SSH_AUTH_SOCK=$SOCK
	fi

    if [ ! -z "$SSH_TTY" ]; then
        # We logged in via SSH
        # start tmux
        tmux attach
    fi
fi

# disable flow control
stty -ixon


alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias l='ls $LS_OPTIONS -lAhF'
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias g=git

alias vi='vim'
alias vims='vim --servername=vim'
alias vimc='vim --remote-tab'
alias less='less -R -x4'
# ncurses emulates 8 color term when TERM is xterm
# but we need 16 color
alias tmux='TERM=xterm-16color tmux'
