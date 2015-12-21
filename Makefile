USERBASE := $(shell python -m site --user-base)
ANSIBLE := $(shell which ansible)

ifeq ($(ANSIBLE),)
	ANSIBLE := $(shell which $(USERBASE)/bin/ansible)
endif
ifeq ($(ANSIBLE),)
	ANSIBLE_INSTALLATION := $(shell easy_install --user ansible)
	ANSIBLE := $(shell which $(USERBASE)/bin/ansible)
endif

OS_FAMILY := $(shell cat $(CURDIR)/roles/os_family)
ifeq ($(OS_FAMILY),)
	OS_FAMILY := $(shell $(ANSIBLE) localhost -i inventory.ini -m setup -a 'filter=ansible_os_family' |grep ansible_os_family |cut -d'"' -f4)
	DUMMY := $(shell echo $(OS_FAMILY) > $(CURDIR)/roles/os_family)
endif

PLAYBOOK ?= playbook.$(OS_FAMILY).yml
ANSIBLE_ARGS ?= --ask-sudo-pass

.PHONY: all
all: bootstrap provision update_vim

.PHONY: bootstrap
bootstrap:
ifeq ($(OS_FAMILY), Darwin)
	$(ANSIBLE)-galaxy install -r roles.Darwin.txt --ignore-errors
endif

.PHONY: provision
provision:
	$(ANSIBLE)-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS)

.PHONY: pull
pull:
	git pull --rebase

.PHONY: update_vim
update_vim:
	vim +NeoBundleUpdate +qall
