OS_FAMILY = $(shell ansible localhost -i inventory.ini -m setup -a 'filter=ansible_os_family' |grep ansible_os_family |cut -d'"' -f4)
PLAYBOOK ?= playbook.$(OS_FAMILY).yml
ANSIBLE_ARGS ?= --ask-sudo-pass

.PHONY: all
all: bootstrap provision update_vim

.PHONY: bootstrap
bootstrap:
ifeq ($(OS_FAMILY), Darwin)
	ansible-galaxy install -r roles.Darwin.txt --ignore-errors
endif

.PHONY: provision
provision:
	ansible-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS)

.PHONY: copy_plists
copy_plists:
	ansible-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS)

.PHONY: pull
pull:
	git pull --rebase

.PHONY: update_vim
update_vim:
	vim +NeoBundleInstall! +qall
