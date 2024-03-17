My personal dotfiles configured by Ansible.

I use them on following platforms:

* Fedora
* openSUSE
* Debian
* MacOS X
* FreeBSD

Key components of my dev environment:

* tmux
* Vim
* bash

Checklist - fresh OS X System
-----------------------------

* Install Command Line Tools
* SSD related:
	* Enable trim if you use third party SSDs: sudo trimforce enable 
	* disable local Time Machine snapthots: sudo tmutil disablelocal
* provision using `make`
* run apps in current session
	* Configure Caps Lock behaviour in System Preferences
	* Karabiner-Elements
	* Spectacle
	* Iterm2
* add newer bash (/usr/local/bin/bash) to /etc/shells
* change defalt shell to bash- chsh -s /usr/local/bin/bash

* To automate:
	* Minimize Dock
	* Disable mru sort

		* defaults write com.apple.dock mru-spaces -bool false

	* Create 6 workspaces
