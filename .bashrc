# DXist's .bashrc


# Source global definitions
# import /etc/bashrc in ~/.bashrc.local if you need it
# if [ -r /etc/bashrc ]; then
# 	. /etc/bashrc
# fi

# functions
. ~/.bash_functions

if [[ "${PATH}" != *$HOME/bin* ]]; then
	export PATH=$HOME/bin:$PATH
fi

if [[ "${PATH}" != *$HOME/go/bin* ]]; then
	export PATH=$PATH:$HOME/go/bin
fi

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# platform specific bashrc
if [ -r ~/.bashrc.platform ]; then
	. ~/.bashrc.platform
fi

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

export EDITOR=vim

# use neovim instead of vim if available
if hash nvim 2>/dev/null; then
	alias vim=nvim
	export EDITOR=nvim
fi
# quit less if one output fits on one screen
export PAGER="less -FX"
export LESSOPEN="|pygmentize -g -O encoding=utf-8 %s"
# ignore commands that start from space
export HISTCONTROL=ignorespace
# Turn on parallel history
shopt -s histappend
history -a
# Make bash check its window size after a process completes
shopt -s checkwinsize

# Git config
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# If experience performance issues for large repositoriges
# git config bash.showDirtyState false
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true


export PYTHONSTARTUP=~/.pythonrc
export GPG_TTY=$(tty)

if [[ "$TERM" != "dumb" && "$TERM" != screen* ]]; then
	if [ -z "$LS_OPTIONS" ]; then
		export LS_OPTIONS='--color=auto'
	fi
	if [ -r ~/.dir_colors -a "`which dircolors`" ]; then
		eval `dircolors ~/.dir_colors`
	fi
fi

if [[ "${GOPATH}" != *$HOME/go* ]]; then
	if [[ -z "${GOPATH}" ]]; then
		export GOPATH=$HOME/go
	else
		export GOPATH=$HOME/go:$GOPATH
	fi
fi

venvwrapper=`which virtualenvwrapper.sh`

if [ -r  "$venvwrapper" -o -n "$(type -t workon)" ]; then
	export WORKON_HOME=~/envs
	export PROJECT_HOME=${PROJECT_HOME:-$HOME/workspace}
	if [ -z "$VIRTUALENVWRAPPER_PYTHON" ]; then
		export VIRTUALENVWRAPPER_PYTHON=`which python`
	fi
	if [ -r "$venvwrapper" ]; then
		. "$venvwrapper"
	fi
fi

export PYENV_ROOT="$HOME/.pyenv"

if [[ "${PATH}" != *$HOME/$PYENV_ROOT/bin* ]]; then
	export PATH=$PYENV_ROOT/bin:$PATH
fi

# disable flow control
stty -ixon
alias reset='reset && stty -ixon'


alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias l='ls $LS_OPTIONS -lAhF'
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'

alias vi='vim'
alias vims='vim --servername=vim'
alias vimc='vim --remote-tab'
alias less='less -R -x4'
alias ag='ag --hidden'
alias ap='ansible-playbook'
# ncurses emulates 8 color term when TERM is xterm
# but we need 16 color
alias tmux='TERM=xterm-16color tmux'

alias pbcopy='reattach-to-user-namespace pbcopy'
alias pbpaste='reattach-to-user-namespace pbpaste'
alias tailf='LESSOPEN="" less +F'

alias cindex='cindex -exclude ~/.agignore'
alias csearch_pwd='csearch -f `pwd`'
alias hpr='hub pull-request'
alias hb='hub browse'

if [ "$TMUX" ]; then
	alias sudo='TERM=screen sudo'
	alias su='TERM=screen su'
	alias ssh='TERM=screen ssh'
	alias vagrant='TERM=screen vagrant'
fi

if hash tmuxp.bash 2>/dev/null; then
	source tmuxp.bash
fi

if [[ -z "$TMUX" && $TERM != screen*  ]]; then
	# we're not in a tmux session
	# Predictable SSH authentication socket location.
	SOCK="/tmp/ssh-agent-$USER-tmux"
	if [[ "$SSH_AUTH_SOCK" &&  $SSH_AUTH_SOCK != $SOCK ]]
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


if hash pyenv 2>/dev/null; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# local settings
if [ -r ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
