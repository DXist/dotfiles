USERBASE := $(shell python3 -m site --user-base)
ANSIBLE := $(shell which ansible)

ifeq ($(ANSIBLE),)
	ANSIBLE := $(USERBASE)/bin/ansible
endif

OS_FAMILY := $(shell $(ANSIBLE) localhost -i inventory.ini -m setup -a 'filter=ansible_os_family' |grep ansible_os_family |cut -d'"' -f4)
# OS_FAMILY := Debian

OS_FAMILY := $(shell cat $(CURDIR)/roles/os_family)
ifeq ($(OS_FAMILY),)
	OS_FAMILY := $(shell $(ANSIBLE) localhost -i inventory.ini -m setup -a 'filter=ansible_os_family' |grep ansible_os_family |cut -d'"' -f4)
	DUMMY := $(shell echo $(OS_FAMILY) > $(CURDIR)/roles/os_family)
endif

PLAYBOOK ?= playbook.$(OS_FAMILY).yml
ANSIBLE_ARGS ?= --ask-become-pass

.PHONY: all
all: bootstrap provision update_vim

.PHONY: initial
initial: bootstrap provision_initial

.PHONY: bootstrap
bootstrap:
ifeq ($(OS_FAMILY), Darwin)
	$(ANSIBLE)-galaxy install -r requirements.Darwin.yml --ignore-errors
endif

.PHONY: provision_initial
provision_initial:
	$(ANSIBLE)-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS) --skip-tags=pippackages

.PHONY: provision
provision:
	$(ANSIBLE)-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS)

.PHONY: pull
pull:
	git pull --rebase

.PHONY: update_vim
update_vim:
	nvim +PlugUpdate +qall
