setlocal expandtab
setlocal softtabstop=4
setlocal textwidth=88
setlocal commentstring=#%s
setlocal fdm=indent
" setlocal errorformat=\%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z\ \ \ \ %m
setlocal omnifunc=pythoncomplete#Complete
nnoremap <buffer> <leader>jf :YcmCompleter GoToDeclaration<CR>
nnoremap <buffer> <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <buffer> <leader>jr :YcmCompleter GoToReferences<CR>

if v:version>=703
	setlocal cc=88
endif

let b:delimitMate_smart_quotes = 0

" python << EOF
" import os
" import sys
" import vim

" if not sys.path.count('.'): sys.path.insert(0, '.')
" for p in sys.path:
"     # Add each directory in sys.path, if it exists.
"     if os.path.isdir(p):
"         # Command 'set' needs backslash before each space.
"         vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
" EOF
