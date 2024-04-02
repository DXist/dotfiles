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

* Ensure Apple's command line tools are installed (xcode-select --install to launch the installer).

Install Ansible for initial run:

* pip3 install --user ansible

* SSD related:
	* Enable trim if you use third party SSDs: sudo trimforce enable 
	* disable local Time Machine snapthots: sudo tmutil disablelocal
* provision with system python

    * make initial

    * to fix [TypeError](https://github.com/geerlingguy/ansible-collection-mac/issues/92) with brew

        /opt/homebrew/bin/brew update --auto-update

* Run bash shell. Install ansible for Homerew Python.

    pipx install --include-deps ansible

* Provision with homebrew python:

    * make

* run apps in current session
	* Configure Caps Lock behaviour in System Preferences
	* Karabiner-Elements
	* Spectacle
	* Iterm2
* add newer bash (/opt/homebrew/bin/bash) to /etc/shells

* change default shell to bash- chsh -s /opt/homebrew/bin/bash

* To automate:

    * Create 6 workspaces
