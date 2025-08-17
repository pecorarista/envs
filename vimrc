if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  "Colorscheme
  Plug 'jonathanfilip/vim-lucius'

  "Syntax
  Plug 'junegunn/vim-easy-align'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'scrooloose/syntastic'
  Plug 'dense-analysis/ale'
  "AppleScript
  Plug 'vim-scripts/applescript.vim'
  "Ansible
  Plug 'chase/vim-ansible-yaml'
  "Git
  Plug 'samoshkin/vim-mergetool'
  Plug 'rhysd/conflict-marker.vim'
  "HTML
  Plug 'othree/html5.vim'
  "JavaScript
  Plug 'othree/yajs.vim'
  "Jinja
  Plug 'Glench/Vim-Jinja2-Syntax'
  "jq
  Plug 'vito-c/jq.vim'
  "Markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  "Nginx
  Plug 'chr4/nginx.vim'
  "Pug
  Plug 'digitaltoad/vim-pug'
  "Postgres
  Plug 'lifepillar/pgsql.vim'
  "Python
  Plug 'davidhalter/jedi-vim'
  Plug 'vim-python/python-syntax'
  "Rust
  Plug 'rust-lang/rust.vim'
  "Scala
  Plug 'derekwyatt/vim-scala'
  "SQL
  Plug 'mattn/vim-sqlfmt'
  "Terraform
  Plug 'hashivim/vim-terraform'
  "Toml
  Plug 'cespare/vim-toml'
  "TypeScript
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'Shougo/vimproc', { 'do': 'make' }
  Plug 'Quramy/tsuquyomi'
call plug#end()

set encoding=utf-8
set fileencoding=utf-8
set shortmess+=I
set number
set termbidi
syntax on
set t_Co=256
try
  let g:lucius_style = 'dark'
  let g:lucius_contrast = 'normal'
  colorscheme lucius
catch
  colorscheme default
endtry

highlight Normal ctermbg=NONE
highlight Pmenu ctermfg=White
highlight PmenuSel ctermfg=Red
highlight Pmenu ctermbg=Black
highlight CursorColumn ctermbg=Cyan

"Typescript
highlight link tsxTagName Keyword
highlight link tsxCloseString Keyword
highlight link tsxCloseTag Function

set laststatus=2

set backspace=indent,eol,start
set clipboard=unnamedplus

let s:clip = 'wl-copy'
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @") | endif
  augroup END
endif

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

autocmd BufRead,BufNewFile *.bbx,*.cbx set filetype=tex
autocmd BufRead,BufNewFile *.nginxconf set filetype=nginx
autocmd BufRead,BufNewFile *.rs set filetype=rust

autocmd FileType dot,html,javascript,jinja.html,json,lua,pug,scss,sql,typescript,typescriptreact,yaml
  \ setlocal tabstop=2 softtabstop=2 shiftwidth=2

nnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-y> <Nop>
nnoremap <C-i> :IndentGuidesToggle<CR>

"JavaScript, CSS, Python
let g:ale_linters = {'scss': ['stylelint'], 'typescriptreact': ['eslint']}
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:syntastic_python_checkers = ['flake8']

"Git
let g:mergetool_layout = 'mr'

"Markdown
autocmd FileType markdown EnableWhitespace

"Python
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 1
let g:jedi#completions_command = '<C-b>'

"Postgres
let g:sql_type_default = 'pgsql'

"Rust
let g:rustfmt_autosave = 1

"SQL
let g:sqlfmt_program = 'pg_format --spaces 2 --type-case 2 -o %s -'

"Typescript
let g:tsuquyomi_completion_detail = 1
autocmd FileType python,typescript,typescript.tsx setlocal completeopt-=preview
