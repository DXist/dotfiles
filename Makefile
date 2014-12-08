.PHONY: all
all: bootstrap provision update_vim

.PHONY: bootstrap
bootstrap:
ifndef ROLES
	$(info ROLES is not defined skipping)
else
	ansible-galaxy install -r $(ROLES) --ignore-errors
endif

.PHONY: provision
provision:
ifndef PLAYBOOK
	$(error PLAYBOOK is not defined)
endif
	ansible-playbook -i inventory.ini $(PLAYBOOK) $(ANSIBLE_ARGS)

.PHONY: pull
pull:
	git pull --rebase

.PHONY: update_vim
update_vim:
	vim +NeoBundleInstall! +qall
