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
Plug 'davidhalter/jedi-vim'

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

"Python
Plug 'andviro/flake8-vim'
Plug 'davidhalter/jedi-vim'

"Rust
Plug 'rust-lang/rust.vim'

"Scala
Plug 'derekwyatt/vim-scala'

call plug#end()

set number
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
autocmd BufNewFile,BufRead *.tsv
  \ setlocal noexpandtab |
  \ setlocal list
autocmd BufNewFile,BufRead *.bib,*.coffee,*.css,*.hamlet,*.js,*.scala.html
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2
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
hi Normal ctermbg=NONE guibg=NONE
hi Pmenu ctermfg=White
hi PmenuSel ctermfg=Red
hi Pmenu ctermbg=Black
hi Special guifg=#66D9EF guibg=bg gui=bold
hi CursorColumn ctermbg=Cyan
inoremap <C-e> <End>
inoremap <C-f> <Right>
nnoremap <C-e> <End>
nnoremap <C-f> <Right>
nnoremap <buffer> <silent> <Leader>q :<C-u>QuickRun<CR>
let g:neocomplete#enable_at_startup = 1

"Haskell
let g:necoghc_enable_detailed_browse=1
let g:haskell_conceal_enumerations=0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell setlocal foldmethod=manual
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>g :<C-u>GhcModCheckAndLintAsync<CR>
autocmd Filetype haskell nnoremap <silent> <Leader>t :<C-u>GhcModType<CR>
autocmd FileType haskell nnoremap <silent> <Leader>c :<C-u>GhcModTypeClear<CR>

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

"Markdown
let g:previm_open_cmd = 'google-chrome'

"Python
let g:syntastic_python_checkers = ["flake8"]
set listchars=tab:>-,extends:<,trail:-,eol:$