#!/usr/bin/env bash
#
# Based on
# ~rainerborene dotfiles

DOTIGNORE="(\.git$)|(\.gitmodules$)|(\.xinitrc)|~"
DOTHOME=`dirname $0`
cd $DOTHOME
DOTHOME=`pwd`

# from_dir:file:to_dir
LINK_MAP="
gnome-terminal:keybindings:.gconf/apps/gnome-terminal
:awesome:.config
:bin:
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

	git submodule update --init --recursive \
	&& git submodule foreach --recursive git pull origin master

	compile

	echo "*** Update finished"
	if ask "Commit this update?"; then
		cd $DOTHOME/.vim
		git commit -a -m "Automated submodule update"
		cd $DOTHOME
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


install_links() {
	backuplink() {
		from=`realpath $1`
		todir=`realpath $2`
		file=$3
		if [ -e $todir/$file -a ! -h $todir/$file ]; then
			echo "$todir/$file backed up to $todir/_${file}"
			mv $todir/$file $todir/_${file}
		fi
		echo "Link for $from/$file to $todir/$file"
		ln -sfT $from/$file $todir/$file
	}
	echo "*** Creating symbolic links"
	for file in `ls -d .??* |egrep -v $DOTIGNORE`
	do
		backuplink $DOTHOME $HOME $file
	done

	for line in $LINK_MAP
	do
		from=`echo $line|awk -F ":" '{ print $1 }'`
		file=`echo $line|awk -F ":" '{ print $2 }'`
		to=`echo $line|awk -F ":" '{ print $3 }'`
		mkdir -p $HOME/$to
		backuplink $DOTHOME/$from $HOME/$to $file
	done
}

install() {
	update
	install_links
	checkdeps

	echo "*** Installed"
}


# Parse arguments
case $1 in
	update) update; exit ;;
	checkdeps) checkdeps; exit ;;
	compile) compile; exit ;;
	install_links|*) install_links; exit ;;
	install|*) install; exit ;;
esac
