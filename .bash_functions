# functions
function del() {
	if [ $# -eq 0 ]; then
		return 1
	fi
	dir=/tmp/.Trash/`date -Iseconds` &&
	mkdir -p $dir
    mv -f "$@" $dir
}

function ask() {
	echo "$* [y/n]?"
	read ans
	if [ $ans = y -o $ans = Y -o $ans = yes -o $ans = Yes -o $ans = YES ]
	then
		return 0
	fi

	if [ $ans = n -o $ans = N -o $ans = no -o $ans = No -o $ans = NO ]
	then
		return 1
	fi
}

function ctagsify() {
	what=${1:-.}
	tagfile=${2:-.tags}

	ctags_prg=`which ctags`
	if [ -z $ctags_prg ]; then
		echo 'ctags not found'
		return
	fi

	ctags="$ctags_prg -R"

	({
		set -e
		tmpfile=`dirname $tagfile`/tags.$$
		trap "rm -f $tmpfile" EXIT;
		$ctags -f ${tmpfile} ${what} 2>&1 &&
		mv -f ${tmpfile} $tagfile;
	} | grep -v Warning &)
}

function cindexify() {
	what=${1:-.}
	flock=`which flock`

	if [ "$flock" ]; then
		flock="$flock -n /tmp/cindexify.lock"
	fi

	cindex_prg=`which cindex`
	if [ -z $cindex_prg ]; then
		echo 'cindex not found'
		return
	fi

	$flock $cindex_prg -exclude ~/.agignore ${what} 2>/dev/null &
}

# if [ -z "$SSH_TTY" ]; then
	# reindex virtual environments only on local machine
	function pip() {
		command pip "$@"
		status="$?"
		[[ $status = 0 ]] || return $status

		# rebuild virtualenv ctags, codesearch index
		if [[ -n "${VIRTUAL_ENV}" && ("$1" = install || "$1" = uninstall) ]]; then
			pyenv rehash
			ctagsify ${VIRTUAL_ENV} ${VIRTUAL_ENV}/.tags
			cindexify ${VIRTUAL_ENV}
		fi
	}
# fi

function g() {
	if [[ $# = 0 ]]; then
		git status

		if [ "${JIRA_URL}" ]; then
			jiraurl
		fi
	else
		git "$@"
	fi
}
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

function d() {
	docker "$@"
}
complete -F _docker d


function go() {
	TMPDIR=~/tmp `which go` "$@"
	status="$?"
	[[ $status = 0 ]] || return $status

	# rebuild gopath ctags
	if [[ -n "${GOPATH}" && ("$1" = get ) ]]; then
		goworkspace=${GOPATH/:*/}
		ctagsify ${goworkspace} ${goworkspace}/.tags
	fi
}

function gowork() {
	# APPEND current directory to GOPATH
	if [[ "${GOPATH}" != *$PWD* ]]; then
		export GOPATH=${GOPATH/:*/:}$PWD
	fi

	# PS1="${PS1/(*)[/[}"
	export PS1="(`basename $PWD`)"$PS1
}

function cg() {
    cd $GOPATH/src/github.com/DXist/$1;
}

_cg()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    PROJECTS_DIR="$GOPATH/src/github.com/DXist"
    cd ${PROJECTS_DIR}
    # PROJECTS=$(ls ${LOOK_FOR})
    COMPREPLY=( $(compgen -d -- "$cur") )
}
complete -F _cg cg

export DEV_TOOLS="
	pylint
	pylama
	isort
	neovim
	pdbpp
	ipython
	black
	mypy
"

install_dev_tools() {
	if [ -z "$VIRTUAL_ENV" ]; then
		INSTALL_ARGS='--user'
	else
		INSTALL_ARGS=''
	fi

	PIP=${PIP:-pip}
	# easy_install pdbpp
	if [[ `python -c 'import sys; print(sys.version_info>=(3, 4))'` = 'True' ]]; then
		${PIP} install $INSTALL_ARGS mypy
	else
		# python3
		# last pylint doesnt'support quiet mode in python2
		${PIP} install $INSTALL_ARGS pylint==1.7.6
	fi
	${PIP} install $INSTALL_ARGS ${DEV_TOOLS/mypy/}
}


function rgreplace() {
	rg --files-with-matches -0 "$1" | xargs -0 sd "$1" "$2"
}

function topgrep() {
	top -p $(pgrep -d',' $1)
}

function jiraurl() {
	if [ -z "$JIRA_URL" ]; then
		echo JIRA_URL is not defined
		return 1
	fi

	if [ -z "$1" ]; then
		BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
	else
		BRANCH_NAME="$1"
	fi

	ISSUE=$(echo $BRANCH_NAME | grep -Eo '([[:upper:]]+-[0-9]{4,})')

	if [ -n "$ISSUE" ]; then
		echo "$JIRA_URL/browse/$ISSUE"
	else
		echo "Jira task name is not found in branch name"
	fi
}

ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
        local filename="$1"
        shift
        [ "$filename" ] && {
            curl $opts -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

function denter() {
	docker exec -it "$1" /bin/bash
}

function define() {
	gmtrn-cli "$@" |less
}


function linesworked() {
	git log --numstat --pretty='%H' --author='Rinat Shigapov' $@ | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
}

# vim: ft=sh
