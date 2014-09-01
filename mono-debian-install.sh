#!/bin/bash

PREFIX="/usr/local"
PATH=$PREFIX/bin:$PATH

sudo apt-get install wget git autoconf libtool automake build-essential gettext

git clone git://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1

cd mono
./autogen.sh --prefix=$PREFIX \
	--with-mcs-docs=no \
	--with-xammac=no \
	--with-monotouch=no \
	--with-monodroid=no \
	--with-profile2=no \
	--with-profile4=no \
	--with-profile4_5=yes

make get-monolite-latest
make
sudo make install

# Instalando/atualizando os certificados SSL para habilitar as requisicoes HTTPS futuras
sudo mozroots --import --machine --sync
yes | sudo certmgr -ssl -m "https://www.myget.org"
