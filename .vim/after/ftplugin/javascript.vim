setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
setlocal smartindent
setlocal omnifunc=javascriptcomplete#CompleteJS

if executable('node_modules/.bin/eslint')
	  let b:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
	  let b:syntastic_checkers = ['eslint']
endif
