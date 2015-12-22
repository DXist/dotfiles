augroup python_test
	autocmd!
	autocmd FileType python setlocal makeprg=./.runtests\ \ $*
	autocmd FileType python let b:dispatch='PDB="python -m pdb" ' . expand('<sfile>:p:h') . '/.runtests %'
augroup END

python << EOF
import sys
import os
os.environ['DJANGO_SETTINGS_MODULE'] = 'project.settings'

EOF

let g:CtrlSpaceGlobCommand = 'ag -l --hidden --skip-vcs-ignores --nocolor -g ""'
let g:unite_source_grep_default_opts='--hidden --nocolor --nogroup --smart-case --skip-vcs-ignores'
