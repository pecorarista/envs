if [ ! -x $HOME/.linuxbrew/bin/zsh ]
then
    curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh | sh
    $HOME/.linuxbrew/bin/brew install zsh
fi

if [ ! -L $HOME/.zshenv ]
then
    ln -s $HOME/envs/zshenv $HOME/.zshenv
fi
if [ ! -L $HOME/.zshrc ]
then
    ln -s $HOME/envs/zshrc $HOME/.zshrc
fi
exec $HOME/.linuxbrew/bin/zsh -l
