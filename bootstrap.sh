#!/usr/bin/env bash
mkdir -p ~/Development

LIBDIR=~/lib
sudo apt install -y curl git bash-completion emacs-nox silversearcher-ag tmux google-chrome-stable htop
mkdir -p $LIBDIR
pushd $LIBDIR
curl https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar xvz
wget -nc -0 - https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.38.zip | unzip

sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

echo "short circuit"
exit 1

# Clone cwn repo
git clone git@github.com:commonnet/cwn.git ~/Development/cwn
cd ~/Development/cwn
git submodule update --init

read -p "Backup & append .bashrc with GOPATH, PATH etc?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "export GOPATH=~/Development/cwn/go" >> ~/.bashrc
    echo "export PATH=$PATH:$GOPATH/bin" >> ~/.bashrc
    echo "export PATH=$PATH:~/Development/cwn/third_party/protoc/linux" >> ~/.bashrc
fi

cd ~/Development/cwn
make devtools-install
