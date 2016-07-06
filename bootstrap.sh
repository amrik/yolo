#!/usr/bin/env bash
mkdir -p ~/Development

LIBDIR=~/lib
APPENGINESDK=go_appengine_sdk_linux_amd64-1.9.38.zip

sudo apt install -y curl git bash-completion emacs-nox silversearcher-ag tmux google-chrome-stable htop
mkdir -p $LIBDIR
pushd $LIBDIR
curl https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar xvz
wget https://storage.googleapis.com/appengine-sdks/featured/$APPENGINESDK
unzip -o $APPENGINESDK
rm $APPENGINESDK

sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

# Clone cwn repo
git clone git@github.com:commonnet/cwn.git ~/Development/cwn
cd ~/Development/cwn && git submodule update --init
cd $LIBDIR && git clone https://github.com/rupa/z.git

read -p "Backup & append .bashrc with GOPATH, PATH etc?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "export GOROOT=~/lib/go" >> ~/.bashrc
    echo "export GOPATH=~/Development/cwn/go" >> ~/.bashrc
    echo "export PATH=\$PATH:~/lib/go/bin:~/lib/go_appengine:\$GOPATH/bin" >> ~/.bashrc
    echo "export PATH=\$PATH:~/Development/cwn/third_party/protoc/linux" >> ~/.bashrc
    echo "source ~/Development/cwn/etc/aliases" >> ~/.bashrc
    echo ". ~/lib/z/z.sh" >> ~/.bashrc
fi
source ~/.bashrc  # reload bashrc to get go on path
cd ~/Development/cwn
make devtools-install
