# DXist's .bashrc

# Source global definitions
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$HOME/bin:$PATH:/usr/lib/git-core/
export EDITOR=`which vim`

# Git config
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true

venvwrapper=`which virtualenvwrapper.sh`
if [ -r  $venvwrapper ]; then
	export WORKON_HOME=~/envs
	export PROJECT_HOME=~/workspace
	. $venvwrapper
fi

if [ -r /etc/bash_completion.d/git ]; then
	. /etc/bash_completion.d/git
fi

# aliases

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias l='ls -lap'
alias ls='ls -F --color'
alias ll='ls -l'
alias la='ls -lA'

alias vi='vim'
alias sim='sudo vim'

# functions
function del() {
    if [ ! -d /tmp/.Trash ]; then
        mkdir /tmp/.Trash
    fi
    mv -f "$1" /tmp/.Trash/
}

function ask() {
	echo "$* [y/n]?"
	read ans
	if [ $ans = y -o $ans = Y -o $ans = yes -o $ans = Yes -o $ans = YES ]
	then
		return 0
	fi

	if [ $ans = n -o $ans = N -o $ans = no -o $ans = No -o $ans = NO ]
	then
		return 1
	fi
}


# additional settings
if [ -r ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi
