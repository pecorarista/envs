if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'tomasr/molokai'
  Plug 'junegunn/vim-easy-align'
  Plug 'ntpeters/vim-better-whitespace'
  "Ansible
  Plug 'chase/vim-ansible-yaml'
  ".gitignore
  Plug 'rdolgushin/gitignore.vim'
  "Pug
  Plug 'digitaltoad/vim-pug'
  "Postgres
  Plug 'lifepillar/pgsql.vim'
  "Python
  Plug 'scrooloose/syntastic'
  Plug 'davidhalter/jedi-vim'
  "Rust
  Plug 'rust-lang/rust.vim'
  "Toml
  Plug 'cespare/vim-toml'
call plug#end()

set shortmess+=I
set number
set termbidi
syntax on
set t_Co=256
try
  colorscheme molokai
catch
  colorscheme default
endtry
hi Normal ctermbg=NONE guibg=Black
hi Pmenu ctermfg=White
hi PmenuSel ctermfg=Red
hi Pmenu ctermbg=Black
hi Special guifg=#66D9EF guibg=bg gui=bold
hi CursorColumn ctermbg=Cyan
set clipboard=unnamed,unnamedplus

set nobackup
set nowritebackup
set noswapfile

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set ignorecase
set wildignorecase
set hlsearch
set incsearch
set listchars=tab:>-,extends:<,trail:-,eol:$

au BufRead,BufNewFile *.scss set filetype=scss.css
au BufRead,BufNewFile *.nginxconf set filetype=nginx
au BufRead,BufNewFile *.ts set filetype=typescript
au BufRead,BufNewFile *.pug setlocal tabstop=2 softtabstop=2 shiftwidth=2

nnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-y> <Nop>

"Python
let g:syntastic_python_checkers = ['flake8']
let g:jedi#popup_on_dot = 1

"Postgres
let g:sql_type_default = 'pgsql'
