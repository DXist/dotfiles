.PHONY: update
update: pull update_vim install

.PHONY: pull
pull:
	git pull --rebase

.PHONY: update_vim
update_vim:
	cd .vim && make update

.PHONY: install
install:
	go get github.com/junkblocker/codesearch/...
	./setup.sh install_links
