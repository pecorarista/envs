if executable('poetry')
  let s:poetry_prefix = trim(system('poetry env info -p'))
  if v:shell_error == 0 && isdirectory(s:poetry_prefix)
    let s:py = s:poetry_prefix . '/bin/python'
  endif
endif

if !exists('s:py') && executable('pyenv')
  let s:py = trim(system('pyenv which python3'))
endif

if !exists('s:py')
  let s:py = '/usr/bin/python3'
endif

let g:python3_host_prog = s:py
let g:coc_user_config = { 'python.pythonPath': s:py }

call plug#begin(stdpath('data') . '/plugged')
  Plug 'jonathanfilip/vim-lucius'
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:coc_global_extensions = ['coc-pyright', 'coc-diagnostic']

set shortmess+=I
set number

set nobackup
set nowritebackup
set noswapfile

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set guicursor=a:block

set ignorecase
set wildignorecase
set hlsearch
set incsearch
set inccommand=
set listchars=tab:>-,extends:<,trail:-,eol:$

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

try
  let g:lucius_style = 'dark'
  let g:lucius_contrast = 'normal'
  colorscheme lucius
catch
  colorscheme default
endtry

highlight Normal ctermbg=NONE
highlight CocHintFloat guifg=white
highlight CocErrorFloat guifg=#ff8787
highlight CocWarningFloat guifg=#d7d75f

autocmd FileType dot,html,javascript,jinja.html,json,lua,pug,scss,sql,typescript,typescriptreact,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

set clipboard=unnamedplus

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

nnoremap <C-a> <Home>
inoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
nnoremap <C-y> <Nop>

" Git
let g:mergetool_layout = 'mr'
