" VIMRC

" Environment Variables {{{
let $RTP=split(&runtimepath, ',')[0]
let $VIMRC="$HOME/.vim/vimrc"
let $KP_DIR="$HOME/profile.d/util/vim/keywordprg"
" }}}

" Basics {{{
filetype plugin indent on         " Add filetype, plugin, and indent support
syntax on                         " Turn on syntax highlighting
language en_US.UTF-8              " Change language to en_US UTF-8
"}}}

" Settings {{{
set backspace=indent,eol,start    " Backspace everything in insert mode
set wildmenu                      " Display matches in command-line mode
set expandtab                     " Prefer spaces over tabs in general
set hidden                        " Prefer hiding over unloading buffers
set wildcharm=<C-z>               " Macro-compatible command-line wildchar
set path=.,**                     " Relative to current file and everything under :pwd
setl wildignore=**/node_modules/**,**/dist/**,*.pyc
set noswapfile                    " Disables swapfiles
set tags=./tags;,tags;            " Find tags relative to current file and directory
set t_BE=                         " Disable bracketed paste mode
set relativenumber                " Enable relative line number
set noerrorbells                  " Be quiet
set tabstop=2 softtabstop=2       " Set tab to 2 spaces
set shiftwidth=2
set smartindent                   " Use smartindent
set scrolloff=3                   " Activate line 4 as top/bottom line for zt
set nowrap												" Do not break lines
set smartcase											" Option for search to ignore case insensitive if a upper char is used
set ignorecase                    " Turn on ignore case for searching
set incsearch                     " Start searching while typing
set shortmess+=c									" Don't pass messages to ins-completion-menu
colorscheme nord                  " Set nord color theme
" }}}

" Vim go (polyglot) settings {{{
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1
" }}}

" Basic key settings {{{
let loaded_matchparen = 1
let mapleader = " "
" }}}

" Netrw settings {{{
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
" }}}

" Split and window settings {{{
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }}}

" FuGITive settings {{{
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
" }}}

" Whitespace handling {{{
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
" }}}

" Autogroups {{{
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END
" }}}

