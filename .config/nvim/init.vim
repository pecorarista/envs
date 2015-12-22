set runtimepath+=~/.config/nvim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.config/nvim/bundle/'))

"Vim
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'tomasr/molokai'
NeoBundle 'freeo/vim-kalisi'

"Ansible
NeoBundle 'chase/vim-ansible-yaml'

"Scala
NeoBundle 'derekwyatt/vim-scala'

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
set t_Co=256
syntax on
colorscheme molokai
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
