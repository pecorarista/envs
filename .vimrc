set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Bundle 'andviro/flake8-vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'davidhalter/jedi-vim'
Bundle 'dag/vim2hs'
Bundle 'def-lkb/merlin'
Bundle 'derekwyatt/vim-scala'
Bundle 'digitaltoad/vim-jade'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'eagletmt/neco-ghc'
Bundle 'eagletmt/unite-haddock'
Bundle 'gmarik/Vundle.vim'
Bundle 'gregsexton/gitv'
Bundle 'hugoroy/.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'junegunn/vim-easy-align'
Bundle 'kannokanno/previm'
Bundle 'lambdatoast/elm.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'osyo-manga/vim-reunions'
Bundle 'osyo-manga/vim-marching'
Bundle 'othree/html5.vim'
Bundle 'pbrisbin/vim-syntax-shakespeare'
Bundle 'plasticboy/vim-markdown'
Bundle 'Shougo/neocomplete'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'scrooloose/syntastic'
Bundle 'thinca/vim-quickrun'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-fugitive'
Bundle 'tyru/open-browser.vim'
Bundle 'ujihisa/ref-hoogle'
Bundle 'vim-scripts/dbext.vim'
call vundle#end()
filetype plugin indent on
set number
set shortmess+=I
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set nobackup
set nowritebackup
set noswapfile
set nofoldenable
set viminfo=
set ignorecase
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set laststatus=2
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%)\ %p%%
set t_Co=256
set termbidi
syntax on
nnoremap <C-s> :w<CR>
vnoremap <C-s> <C-c>:w<CR>
inoremap <C-s> <C-o>:w<CR>
colorscheme molokai-transparent
hi clear Conceal
let g:neocomplete#enable_smart_case=1
let g:neocomplete#enable_at_startup=1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:marching_clang_command="clang"
let g:marching#clang_command#options="-std=c++11"
let g:marching_enable_neocomplete=1
let g:marching_backend="sync_clang_command"
let g:marching_include_paths=[]
let g:neocomplete#force_omni_input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
function! s:cpp()
	setlocal path+=/usr/include,/usr/local/include,/usr/include/c++/4.8.2,/usr/include/eigen3
endfunction
augroup vimrc-cpp
    autocmd!
    autocmd FileType cpp call s:cpp()
augroup END
let g:jedi#completions_enabled=0
let g:jedi#auto_vim_configuration=0
let g:jedi#popup_on_dot=0
let g:neocomplete#force_omni_input_patterns.python='\h\w*\|[^. \t]\.\w*'
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType tex NeoCompleteLock
nnoremap <silent> <Leader>p :<C-u>call InitializePythonFile()<CR>
"to prevent jedi from stating to detect encoding before string 'utf-8' is completely typed
function! InitializePythonFile()
    1s@^@# -*- encoding: utf-8 -*-@
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
endfunction
let g:necoghc_enable_detailed_browse=1
nnoremap <silent> <Leader>g :<C-u>GhcModCheckAndLintAsync<CR>
inoremap <silent> <C-a> <C-o>:<C-u>call ArabicToggle()<CR>
inoremap <silent> <C-y> <C-o>:<C-u>call HebrewToggle()<CR>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> "_dd
nnoremap <silent> <C-a> :<C-u>call ArabicToggle()<CR>
nnoremap <silent> <C-y> :<C-u>call HebrewToggle()<CR>
nnoremap <C-b> <Left>
nnoremap <C-e> <End>
nnoremap <C-4> <End>
nnoremap <C-f> <Right>
noremap <Leader>m :<C-u>!make<CR>
let g:indent_guides_enable_on_vim_startup=0
nnoremap <silent> <Leader>v :<C-u>IndentGuidesToggle<CR>
let g:indent_guides_guide_size=4
let g:PyFlakeOnWrite=0
let g:previm_open_cmd='google-chrome --new-window'
let g:haskell_conceal_enumerations=0
au BufNewFile,BufRead *.md nnoremap <silent> <C-p> :<C-u>PrevimOpen<CR>
function! LuaTeXCompile()
    !lualatex %
    !evince %<.pdf &
endfunction
au BufNewFile,BufRead *.tex nnoremap <silent> <Leader>l :<C-u>call LuaTeXCompile()<CR>
function! TransparencyToggle()
    if (g:colors_name=='molokai')
        colorscheme molokai-transparent
    else
        colorscheme molokai
    endif
endfunction
"use a terminal-emulator which supports right-to-left writing
function! ArabicToggle()
    if(&arabic)
        set noarabic
    else
        set arabic
    endif
endfunction
function! HebrewToggle()
    if(&keymap=="hebrewp")
        set keymap=
    else
        set keymap=hebrewp
    endif
endfunction
function! IPA()
    s/I/ɪ/egI | s/U/ʊ/egI
    s/@/ə/egI
    s/E/ε/egI | s/3/ɜ/egI | s/2/ʌ/egI | s/O/ɔ/egI
    s/5/ɐ/egI
    s/A/ɑ/egI | s/6/ɒ/egI
    s/\^j/ʲ/egI
    s/T/θ/egI | s/D/ð/egI
    s/S/ʃ/egI | s/Z/ʒ/egI
    s/:/ː/egI
    s/""/ˌ/egI | s/"/ˈ/egI
    s/?/ʔ/egI
endfunction
nnoremap <silent> <Leader>i :<C-u>call IPA()<CR><End>
nnoremap <silent> <Leader>o :<C-u>call TransparencyToggle()<CR>
nnoremap <silent> <Leader>t :<C-u>GhcModType<CR>
nnoremap <silent> <Leader>c :<C-u>GhcModTypeClear<CR>
nnoremap <C-h> :<C-u>UniteWithCursorWord hoogle<CR>
let g:unite_source_haddock_browser='google-chrome --new-window'
command OpenFileExplorer VimFilerBufferDir -split -simple -winwidth=30 -no-quit -no-focus
let g:vimfiler_as_default_explorer=1
if (&diff)
    nnoremap <silent> <ESC>p :.diffput<CR>
    nnoremap <silent> <ESC>o :.diffget<CR>
endif
let dbext_default_type="PGSQL"
let dbext_default_user="postgres"
let dbext_default_passwd=""
let dbext_default_dbname=""
let dbext_default_host="localhost"
augroup filetypedetect
    au BufNewFile,BufRead *.css,*.hamlet setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
"opam install omake
"https://github.com/the-lambda-church/merlin/wiki/vim-from-scratch
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']
"https://github.com/tyru/dotfiles/blob/master/dotfiles/.vim/dict/scala.dict
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }
