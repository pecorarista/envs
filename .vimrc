if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \   'windows' : 'tools\\update-dll-mingw',
  \   'cygwin' : 'make -f make_cygwin.mak',
  \   'mac' : 'make -f make_mac.mak',
  \   'linux' : 'make',
  \   'unix' : 'gmake',
  \   },
  \ }
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tomasr/molokai'
NeoBundle 'tyru/open-browser.vim'

"Ansible
NeoBundle 'chase/vim-ansible-yaml'

"C & C++
NeoBundleLazy 'osyo-manga/vim-marching', {
  \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
  \ 'autoload' : {'filetypes' : ['c', 'cpp']}
  \ }

"CoffeeScript
NeoBundle 'kchmck/vim-coffee-script'

"Git
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-fugitive'

"Haskell
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'pbrisbin/vim-syntax-shakespeare'

"HTML5
NeoBundle 'othree/html5.vim'

"Markdown
NeoBundle 'kannokanno/previm'
NeoBundle 'plasticboy/vim-markdown'

"OCaml
NeoBundle 'def-lkb/merlin'

"Python
NeoBundle 'andviro/flake8-vim'

"Scala
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'gre/play2vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

set number
set shortmess+=I
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set nofoldenable
autocmd FileType make setlocal noexpandtab
augroup filetypedetect
  \ au BufNewFile,BufRead
  \ *.bib,*.coffee,*.hamlet,*.js,*.scala.html,*.txt,*.yml
  \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
set nobackup
set nowritebackup
set noswapfile
set ignorecase
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set termbidi
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%)\ %p%%
set t_Co=256
syntax on
colorscheme molokai
hi Normal ctermbg=NONE
hi clear Conceal
hi Pmenu ctermfg=White
hi PmenuSel ctermfg=Red
hi Pmenu ctermbg=Black

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
set hlsearch
let g:incsearch#auto_nohlsearch=1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

inoremap <C-e> <End>
inoremap <C-f> <Right>
nnoremap <C-e> <End>
nnoremap <C-f> <Right>
nnoremap <C-f> <Right>

let g:neobundle#log_filename=$HOME . "/neobundle.log"
let g:better_whitespace_filetypes_blacklist=['git']
let g:neocomplete#enable_smart_case=1
let g:neocomplete#enable_at_startup=1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns={}
endif
nnoremap <buffer> <silent> <Leader>q :<C-u>QuickRun<CR>

"C & C++
let g:marching_clang_command='clang'
let g:marching#clang_command#options='-std=c++11'
let g:marching_enable_neocomplete=1
let g:marching_backend='sync_clang_command'
let g:neocomplete#force_omni_input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

"Haskell
let g:necoghc_enable_detailed_browse=1
let g:haskell_conceal_enumerations=0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd fileType haskell nnoremap <buffer> <silent> <Leader>g :<C-u>GhcModCheckAndLintAsync<CR>
nnoremap <silent> <Leader>t :<C-u>GhcModType<CR>
nnoremap <silent> <Leader>c :<C-u>GhcModTypeClear<CR>

"Java
au BufNewFile,BufRead *.java set tags+=$HOME/tags/java.tags

"LaTeX
let g:quickrun_config = {}
let g:quickrun_config = {
  \   '_' : {
  \     'outputter/buffer/split' : ':botright 8sp',
  \     'outputter/buffer/close_on_empty' : 1,
  \     'runner' : 'vimproc',
  \   },
  \   'tex' : {
  \     'command' : 'latexmk',
  \     'cmdopt' : '-pv -shell-escape',
  \     'exec': ['%c %o %s']
  \   },
  \ }

"OCaml
"opam install omake
"opam install merlin
"https://github.com/the-lambda-church/merlin/wiki/vim-from-scratch
"<C-x><C-o>
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
let g:syntastic_ocaml_checkers = ['merlin']

"Python
let g:syntastic_python_checkers = ["flake8"]

"Scala
au BufNewFile,BufRead *.scala set tags+=$HOME/tags/scala.tags
nnoremap <silent> <Leader>s :<C-u>:VimFiler $HOME/.nyandoc<CR><End>

"VimFiler
let g:vimfiler_as_default_explorer = 1
autocmd FileType vimfiler nmap <buffer> <C-h> <Plug>(vimfiler_switch_to_history_directory)
autocmd FileType vimfiler nmap <buffer> <BS> <Plug>(vimfiler_switch_to_parent_directory)

"Unite
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nnoremap <C-p> <C-u>:bp<CR><End>

"ŋ Compose n + g
"ə Compose e + e
function! IPA()
  s/I/ɪ/egI | s/U/ʊ/egI
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
