# if running bash
if [ -n "$BASH_VERSION" ]; then
	if [ "`which gpg-agent`" -a -z "${GPG_AGENT_INFO}"]; then
		if [[ $- == *i* ]] ; then
			eval $(gpg-agent --daemon)
		fi
	fi
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
