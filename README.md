### 初期設定 (Ubuntu)

```sh
sudo apt-get update
sudo apt-get upgrade
sudo do-release-upgrade -d
sudo apt-get install nvidia-340
reboot
sudo apt-get install fcitx fcitx-mozc kde-config-fcitx
im-config -n fcitx
echo 'export GTK_IM_MODULE=fcitx' >> ~/.profile
echo 'export QT_IM_MODULE=fcitx' >> ~/.profile
echo 'export XMODIFIERS="@im=fcitx"' >> ~/.profile
sudo apt-get install tmux git

# Google Chrome, Slack, Skype, Dropbox
sudo apt-get install sni-qt:i386

# Java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo update-alternatives --config java

# Scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt

# TeXLive
sudo apt-get install texlive-full xzdec
tlmgr init-usertree
tlmgr update --self

# Haskell
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
echo 'deb http://download.fpcomplete.com/ubuntu wily main' | sudo tee /etc/apt/sources.list.d/fpco.list
sudo apt-get update
sudo apt-get install stack
stack setup
stack install cabal-install
stack install ghc-mod
git clone https://github.com/belliture/ghc-mod-stack-wrapper.git ~/Library/ghc-mod-stack-wrapper
chmod +x ~/Library/ghc-mod-stack-wrapper/linux/ghc-mod
chmod +x ~/Library/ghc-mod-stack-wrapper/linux/ghc-modi
ln -s ~/Library/ghc-mod-stack-wrapper/linux/ghc-mod ~/bin/ghc-mod
ln -s ~/Library/ghc-mod-stack-wrapper/linux/ghc-modi ~/bin/ghc-modi

# Node.js
sudo apt-get install nodejs npm
sudo npm install -g n
sudo n stable
```
