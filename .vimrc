if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'tomasr/molokai'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'tyru/open-browser.vim'

  Plug 'ntpeters/vim-better-whitespace'
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'Shougo/neocomplete.vim'

  "Ansible
  Plug 'chase/vim-ansible-yaml'

  "Markdown
  Plug 'kannokanno/previm'

  "Python
  Plug 'nvie/vim-flake8'
call plug#end()

set shortmess+=I
syntax on
set t_Co=256
try
  colorscheme molokai
catch
  colorscheme default
endtry
set clipboard=unnamed,unnamedplus
hi Normal ctermbg=NONE guibg=Black
hi Pmenu ctermfg=White
hi PmenuSel ctermfg=Red
hi Pmenu ctermbg=Black
hi Special guifg=#66D9EF guibg=bg gui=bold
hi CursorColumn ctermbg=Cyan

set nobackup
set nowritebackup
set noswapfile
set termbidi

set number
set ignorecase
set hlsearch

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

au BufRead,BufNewFile *.scss set filetype=scss.css
au BufRead,BufNewFile *.nginxconf set filetype=nginx
au BufRead,BufNewFile *.ts set filetype=typescript

nnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-f> <Right>
inoremap <C-f> <Right>
nnoremap <C-b> <Left>
inoremap <C-b> <Left>
nnoremap <C-y> <Nop>
inoremap <C-`> <Nop>

"Markdown
let g:previm_open_cmd = 'google-chrome'

"Python
let g:syntastic_python_checkers = ["flake8"]
"let g:flake8_ignore="E731"
set listchars=tab:>-,extends:<,trail:-,eol:$

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ 12
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set guioptions-=R
  set guioptions-=L
endif
