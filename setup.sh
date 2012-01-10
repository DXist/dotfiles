#!/usr/bin/env bash
#
# Based on
# ~rainerborene dotfiles

DOTIGNORE="(\.git$)|(\.gitmodules$)|(\.xinitrc)|~"
DOTHOME=`dirname $0`
cd $DOTHOME
DOTHOME=`pwd`

LINK_MAP="
gnome-terminal/keybindings:.gconf/apps/gnome-terminal/
awesome:.config/
bin:bin/
"
#
# Git must be installed on your machine.
#

if ! type -p git &> /dev/null; then
	echo "What? You don't have Git installed."
	exit 1
fi

compile() {
	echo "*** Compiling extensions..."
	cd $DOTHOME/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make
	cd $DOTHOME/.vim/bundle/vimproc && make -f make_gcc.mak
}

update() {
	local github="https://raw.github.com"

	echo "*** Updating..."

	git submodule update --init \
	&& git submodule foreach --recursive git submodule update --init \
	&& git submodule foreach --recursive git pull origin master

	compile

	echo "*** Update finished"
	if ask "Commit this update?"; then
		git commit -a -m "Automated submodule update"
	fi
}

checkdeps() {
	echo "*** Checking dependecies"
	if ! type -p ack &> /dev/null; then
		echo "Can't find ack..."
	fi
	echo "Installing pep8..."
	pip install pep8
}

install() {
	update
	echo "*** Creating symbolic links"
	for file in `ls -d .??* |egrep -v $DOTIGNORE`
	do
		if [ -e $HOME/$file -a ! -h $HOME/$file ]; then
			echo "$file backed up to $HOME/_${file:1}"
			mv $HOME/$file $HOME/_${file:1}
		fi
		echo "Link for $file to $HOME/$file"
		ln -sfT $DOTHOME/$file $HOME/$file
	done

	for line in $LINK_MAP
	do
		from=`echo $line|awk -F ":" '{ print $1 }'`
		to=`echo $line|awk -F ":" '{ print $2 }'`
		mkdir -p $HOME/$to
		echo "Link for $from to $HOME/$to"
		ln -sfT $DOTHOME/$from $HOME/$to
	done

	checkdeps

	echo "*** Installed"
}


# Parse arguments
case $1 in
	update) update; exit ;;
	checkdeps) checkdeps; exit ;;
	compile) compile; exit ;;
	install|*) install; exit ;;
esac
