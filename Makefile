.PHONY: all
all: bootstrap provision update_vim

.PHONY: bootstrap
bootstrap:
ifndef ROLES
	$(error ROLES is not defined)
endif
	ansible-galaxy install -r $(ROLES) --ignore-errors

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

.PHONY: install
install:
	./setup.sh install_links
	go get github.com/junkblocker/codesearch/...
