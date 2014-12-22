if exists("current_compiler")
  finish
endif
let current_compiler = "sample_python"

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ \=\-]%\\@=%m,%-G%.%#

CompilerSet makeprg=./manage.py\ test\ --noinput\ $*
