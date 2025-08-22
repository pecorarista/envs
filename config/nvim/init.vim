call plug#begin(stdpath('data') . '/plugged')
  " Colorscheme
  Plug 'jonathanfilip/vim-lucius'

call plug#end()

set shortmess+=I
set number

try
  let g:lucius_style = 'dark'
  let g:lucius_contrast = 'normal'
  colorscheme lucius
catch
  colorscheme default
endtry

highlight Normal ctermbg=NONE

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

set clipboard=unnamed

let g:clipboard = {
  \   'name': 'myClipboard',
  \   'copy': {
  \     '+': 'win32yank.exe -i',
  \     '*': 'win32yank.exe -i',
  \   },
  \   'paste': {
  \     '+': 'win32yank.exe -o',
  \     '*': 'win32yank.exe -o',
  \   },
  \   'cache_enabled': 1,
  \ }


autocmd BufRead,BufNewFile *.rs set filetype=rust

nnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-y> <Nop>

" Git
let g:mergetool_layout = 'mr'

" Markdown
autocmd FileType markdown EnableWhitespace
