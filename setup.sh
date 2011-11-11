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
"
#
# Git must be installed on your machine.
#

if ! type -p git &> /dev/null; then
	echo "What? You don't have Git installed."
	exit 1
fi


update() {
	local github="https://raw.github.com"

	echo "*** Updating..."

	git submodule update --init \
	&& git submodule foreach git pull origin master \
	&& git submodule foreach --recursive git submodule update --init \
	&& git submodule foreach --recursive git pull origin master

	#read -p "Submodules was successfully updated. Are you sure you want to continue [y/n]? " ANSWER
	#[[ $ANSWER == "n" || $ANSWER == "N" ]] && exit

}

install() {
	update
	# Create symbolic links
	for file in `ls -d .??* |egrep -v $DOTIGNORE`
	do
		if [ -e $HOME/$file -a ! -h $HOME/$file ]; then
			mv $HOME/$file $HOME/_${file:1}
		fi
		ln -sf $DOTHOME/$file $HOME/$file
	done

	for line in $LINK_MAP
	do
		from=`echo $line|awk -F ":" '{ print $1 }'`
		to=`echo $line|awk -F ":" '{ print $2 }'`
		mkdir -p $HOME/$to
		ln -sf $DOTHOME/$from $HOME/$to
	done


  # Compile command-t extension
  echo "*** Compiling extensions..."
  cd $DOTHOME/.vim/bundle/command-t && rake make

  # Done
  echo "*** Installed"
}

checkdeps() {
	if ! type -p ack &> /dev/null; then
		echo "*** Can't find ack..."
	fi

	echo "*** Done"
}

# Parse arguments
case $1 in
	update) update; exit ;;
	checkdeps) checkdeps; exit ;;
	install|*) install; exit ;;
esac
