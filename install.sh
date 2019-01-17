#!/bin/bash

if [ ! -x $HOME/.cargo/bin/rustc ]
then
    curl -fsSL https://static.rust-lang.org/rustup.sh | sh
fi
