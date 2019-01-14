if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'tomasr/molokai'
  Plug 'junegunn/vim-easy-align'
  Plug 'tyru/open-browser.vim'

  Plug 'ntpeters/vim-better-whitespace'
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }

  "Ansible
  Plug 'chase/vim-ansible-yaml'

  ".gitignore
  Plug 'rdolgushin/gitignore.vim'

  "Markdown
  Plug 'kannokanno/previm'

  "Pug
  Plug 'digitaltoad/vim-pug'

  "Rust
  Plug 'rust-lang/rust.vim'

  "Postgres
  Plug 'lifepillar/pgsql.vim'

  "Python
  Plug 'scrooloose/syntastic'
  Plug 'davidhalter/jedi-vim'

  "Scala
  Plug 'derekwyatt/vim-scala'

  "Toml
  Plug 'cespare/vim-toml'
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

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set incsearch

set number
set ignorecase
set hlsearch
set termbidi
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

"Markdown
let g:previm_open_cmd = 'google-chrome'

"Postgres
let g:sql_type_default = 'pgsql'

"let g:flake8_ignore="E731"
let g:jedi#popup_on_dot = 1
