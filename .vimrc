if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neocomplete.vim'

Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'
Plug 'tomasr/molokai'
Plug 'tyru/open-browser.vim'

"Ansible
Plug 'chase/vim-ansible-yaml'

"Git
Plug 'tpope/vim-fugitive'

"Markdown
Plug 'kannokanno/previm'

"Hakell
Plug 'dag/vim2hs'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'

"JavaScript
Plug 'pmsorhaindo/syntastic-local-eslint.vim'

"Nginx
Plug 'nginx.vim'

"Python
Plug 'nvie/vim-flake8'
Plug 'davidhalter/jedi-vim'

"reStructuredText
Plug 'Rykka/riv.vim'

"Rust
Plug 'rust-lang/rust.vim'

"Scala
Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-sbt'

"TypeScript
Plug 'leafgarland/typescript-vim'

"Web
Plug 'digitaltoad/vim-pug'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

set number
set hlsearch
set spelllang=en
" set spell
set shortmess+=I
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set nofoldenable
set foldmethod=manual
autocmd FileType make
  \ setlocal noexpandtab |
  \ setlocal list
autocmd BufNewFile,BufRead .XCompose,*.tsv
  \ setlocal noexpandtab |
  \ setlocal list
autocmd BufNewFile,BufRead *.bib,*.coffee,*.css,*.hamlet,*.jade,*.js,*.json,*.ml,*.mli,*.mly,*.pug,*.R,*.sass,*.scala.html,*.scss,*.ts,.vimrc
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2
au BufRead,BufNewFile *.scss set filetype=scss.css
au BufRead,BufNewFile *.nginxconf set filetype=nginx
au BufRead,BufNewFile *.ts set filetype=typescript
set nobackup
set nowritebackup
set noswapfile
set ignorecase
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set termbidi
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%)\ %p%%
syntax on
set t_Co=256
try
  colorscheme molokai
catch
  colorscheme default
endtry
hi clear Conceal
hi Normal ctermbg=NONE guibg=Black
hi Pmenu ctermfg=White
hi PmenuSel ctermfg=Red
hi Pmenu ctermbg=Black
hi Special guifg=#66D9EF guibg=bg gui=bold
hi CursorColumn ctermbg=Cyan
inoremap <C-a> <Home>
inoremap <C-b> <Left>
inoremap <C-e> <End>
inoremap <C-f> <Right>
nnoremap <C-a> <Home>
nnoremap <C-b> <Left>
nnoremap <C-e> <End>
nnoremap <C-f> <Right>
nnoremap <C-y> <Nop>
inoremap <C-`> <Nop>
nnoremap <buffer> <silent> <Leader>q :<C-u>QuickRun<CR>
let g:neocomplete#enable_at_startup = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"Haskell
let g:necoghc_enable_detailed_browse = 1
let g:haskell_conceal_enumerations = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell setlocal foldmethod=manual
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>g :<C-u>GhcModCheckAndLintAsync<CR>
autocmd Filetype haskell nnoremap <silent> <Leader>t :<C-u>GhcModType<CR>
autocmd FileType haskell nnoremap <silent> <Leader>c :<C-u>GhcModTypeClear<CR>

"JavaScript
let g:syntastic_javascript_checkers=['eslint']

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
  \   }
  \ }
let g:syntastic_quiet_messages = { "regex": "Do not use @ in LaTeX macro names"}

"Markdown
let g:previm_open_cmd = 'google-chrome'
autocmd BufNewFile,BufRead *.md set filetype=markdown

"OCaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
let g:syntastic_ocaml_checkers = ['merlin']
execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

"Python
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args = '--ignore=E731,E402,E812'
"let g:flake8_ignore="E731"
set listchars=tab:>-,extends:<,trail:-,eol:$

"Scala
"Be sure to initialize before using eclim by :ProjectCreate . -n scala
let g:syntastic_ignore_files = ['\m\.sbt$']

"International Phonetic Alphabets
digraph I.   618 "ɪ
digraph a5   592 "ɐ
digraph a6   594 "ɒ
digraph U.   650 "ʊ
digraph @.   601 "ə
digraph tS   679 "ʧ
digraph S.   643 "ʃ
digraph \".  712 "ˈ
digraph \"\" 716 "ˌ
digraph :.   720 "ː

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ 12
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set guioptions-=R
  set guioptions-=L
endif
