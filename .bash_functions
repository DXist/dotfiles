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
	cindex_prg=`which cindex`
	if [ -z $cindex_prg ]; then
		echo 'cindex not found'
		return
	fi

	$cindex_prg -exclude ~/.agignore 2>/dev/null &
}

function pip() {
	`which pip` "$@"
	status="$?"
	[[ $status = 0 ]] || return $status

	# rebuild virtualenv ctags
	if [[ -n "${VIRTUAL_ENV}" && ("$1" = install || "$1" = uninstall) ]]; then
		ctagsify ${VIRTUAL_ENV} ${VIRTUAL_ENV}/.tags
	fi
}

function git() {
	GIT_CMD=`which git`
	$GIT_CMD "$@"
	status="$?"
	[[ $status = 0 ]] || return $status

	for opt in "$@"; do
		case "$opt" in
			cm | cma | commit | rebase)
				$GIT_CMD ctags
				break
				;;
		esac
	done
}

function g() {
	if [[ $# = 0 ]]; then
		git status
	else
		git "$@"
	fi
}
complete -F __git_wrap__git_main g

function go() {
	TMPDIR=~/tmp `which go` "$@"
	status="$?"
	[[ $status = 0 ]] || return $status

	# rebuild gopath ctags
	if [[ -n "${GOPATH}" && ("$1" = get ) ]]; then
		goworkspace=${GOPATH%%:*}
		ctagsify ${goworkspace} ${goworkspace}/.tags
	fi
}
# vim: ft=sh
