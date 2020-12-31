set shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab autoindent smartindent
set foldmethod=marker             " Group folds with '{{{,}}}'

" Automatically source .vimrc on save
augroup Vimrc
  autocmd!
  autocmd! bufwritepost .vimrc source %
augroup END

