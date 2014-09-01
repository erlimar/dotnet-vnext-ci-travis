#!/bin/bash

PREFIX="/usr/local"
PATH=$PREFIX/bin:$PATH

sudo apt-get install wget git autoconf libtool automake build-essential gettext > /dev/null

git clone git://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1 > /dev/null

cd mono > /dev/null
./autogen.sh --prefix=$PREFIX \
	--with-mcs-docs=no \
	--with-xammac=no \
	--with-monotouch=no \
	--with-monodroid=no \
	--with-profile2=no \
	--with-profile4=no \
	--with-profile4_5=yes \
	> /dev/null

make get-monolite-latest > /dev/null
make > /dev/null
sudo make install > /dev/null

# Instalando/atualizando os certificados SSL para habilitar as requisicoes HTTPS futuras
sudo mozroots --import --machine --sync > /dev/null
yes | sudo certmgr -ssl -m "https://www.myget.org" > /dev/null
