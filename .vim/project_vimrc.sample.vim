augroup python_test
	autocmd!
	autocmd FileType python setlocal makeprg=./.runtests\ \ $*
	autocmd FileType python let b:dispatch='PDB=python -m pdb ' . expand('<sfile>:p:h') . '/.runtests %'
augroup END

python << EOF
import sys
import os
os.environ['DJANGO_SETTINGS_MODULE'] = 'project.settings'

EOF
