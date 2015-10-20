## Vim
```sh
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

## Python
```sh
w3m https://www.continuum.io/downloads
# Download the latest version of Anaconda
bash Anaconda*
vim ~/.profile
# export ANACONDA_HOME=$HOME/anaconda3
# export PATH=$ANACONDA_HOME/bin:$PATH
    ```

## Haskell
```sh
rm -rf ~/.ghc
rm -rf ~/.cabal
cd ~/Development/Haskell
wget https://www.haskell.org/ghc/dist/7.8.4/ghc-7.8.4-x86_64-unknown-linux-deb7.tar.xz
tar -xvf ghc-7.8.4-x86_64-unknown-linux-deb7.tar.xz
cd ghc-7.84
./configure --prefix=$HOME/Development/ghc-7.8.4
make install
vim ~/.profile
# export GHC_HOME=$HOME/Development/ghc-7.8.4
# export PATH=$GHC_HOME/bin
wget https://www.haskell.org/cabal/release/cabal-1.20.0.3/Cabal-1.20.0.3.tar.gz
tar -xzvf Cabal-1.20.0.3.tar.gz
cd Cabal-1.20.0.3.tar.gz
ghc --make Setup.hs
./Setup configure --user
./Setup build
./Setup install
wget https://www.haskell.org/cabal/release/cabal-install-1.20.1.0/cabal-install-1.20.1.0.tar.gz
tar -xzvf cabal-install-1.20.1.0.tar.gz
cd cabal-install-1.20.1.0
vim ~/.profile
# export CABAL_HOME=$HOME/.cabal
# export PATH=CABAL_HOME/bin:$PATH
. ~/.profile
cabal install ghc-mod
```
See [https://gist.github.com/yantonov/10083524](https://gist.github.com/yantonov/10083524).

```sh
# https://github.com/commercialhaskell/stack
wget -q -O- https://s3.amazonaws.com/download.fpcomplete.com/ubuntu/fpco.key | sudo apt-key add -
echo 'deb http://download.fpcomplete.com/ubuntu/wily stable main'|sudo tee /etc/apt/sources.list.d/fpco.list
sudo apt-get update && sudo apt-get install stack -y
stack setup 7.10.2
stack install ghc-mod
git clone https://github.com/belliture/ghc-mod-stack-wrapper.git ~/Development/ghc-mod-stack-wrapper
cd ~/Development/ghc-mod-stack-wrapper/linux
chmod +x *
cd ~/bin/
ln -s ~/Development/ghc-mod-stack-wrapper/linux/ghc-mod
```

## Scala
```sh
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt

# https://github.com/todesking/nyandoc
```
