call plug#begin('~/.config/nvim/plugged')

Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'
Plug 'tomasr/molokai'

"Ansible
Plug 'chase/vim-ansible-yaml'

"Markdown
Plug 'kannokanno/previm'

"Python
Plug 'andviro/flake8-vim'

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
autocmd FileType make setlocal noexpandtab
augroup filetypedetect
  au BufNewFile,BufRead *.hamlet,*.scala.html,*.bib,*.js,*.coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
set nobackup
set nowritebackup
set noswapfile
set ignorecase
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set termbidi
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%)\ %p%%
syntax on
try
  colorscheme molokai
catch
  colorscheme default
endtry
hi clear Conceal
hi Normal       ctermbg=NONE
hi Normal       guibg=NONE
hi Pmenu        ctermfg=White
hi PmenuSel     ctermfg=Red
hi Pmenu        ctermbg=Black
hi Special      guifg=#66D9EF guibg=bg gui=bold
hi CursorColumn ctermbg=Cyan
inoremap <C-e> <End>
inoremap <C-f> <Right>
nnoremap <C-e> <End>
nnoremap <C-f> <Right>
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = expand('$HOME') . '/anaconda3/bin/python'
nnoremap <buffer> <silent> <Leader>q :<C-u>QuickRun<CR>

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

"Markdown
let g:previm_open_cmd = 'google-chrome'

"Python
let g:syntastic_python_checkers = ["flake8"]
