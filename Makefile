.PHONY: all
all: provision update_vim

.PHONY: provision
provision:
ifndef ROLES
	$(error ROLES is not defined)
endif
ifndef PLAYBOOK
	$(error PLAYBOOK is not defined)
endif
	ansible-galaxy install -r $(ROLES) --ignore-errors
	ansible-playbook -i inventory.ini $(PLAYBOOK)

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
