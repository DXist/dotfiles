.PHONY: update
update:
	git pull --rebase
	cd .vim && make fastupdate
	./setup.sh install_links
