# functions
function del() {
    if [ ! -d /tmp/.Trash ]; then
        mkdir /tmp/.Trash
    fi
    mv -f "$1" /tmp/.Trash/
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

	ctags="`which ctags` -R"

	({
		set -e
		tmpfile=`mktemp -t ctagsify.XXXXXX`
		trap "rm -f $tmpfile" EXIT;
		$ctags -f ${tmpfile} ${what} 2>&1 &&
		mv -f ${tmpfile} $tagfile;
	} | grep -v Warning &)
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
			commit | rebase)
				$GIT_CMD ctags
				break
				;;
		esac
	done
}
# vim: ft=sh
