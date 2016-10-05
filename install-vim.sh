#!/bin/sh
sudo yum install -y \
    ruby \
    ruby-devel \
    lua \
    lua-devel \
    luajit \
    luajit-devel \
    ctags \
    mercurial \
    python \
    python-devel \
    python3 \
    python3-devel \
    tcl-devel \
    perl \
    perl-devel \
    perl-ExtUtils-ParseXS \
    perl-ExtUtils-XSpp \
    perl-ExtUtils-CBuilder \
    perl-ExtUtils-Embed \
    ncurses-devel
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-luainterp \
    --with-lua-prefix=/usr
    --enable-gui=gtk3 \
    --enable-cscope \
make -j
