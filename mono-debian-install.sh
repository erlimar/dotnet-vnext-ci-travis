#!/bin/bash

PREFIX="/usr/local"

sudo apt-get install wget git autoconf libtool automake build-essential gettext > /dev/null 2>&1

PATH=$PREFIX/bin:$PATH
git clone git://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1 > /dev/null 2>&1

cd mono > /dev/null
./autogen.sh --prefix=$PREFIX \
	--with-mcs-docs=no \
	--with-xammac=no \
	--with-monotouch=no \
	--with-monodroid=no \
	--with-profile2=no \
	--with-profile4=yes \
	--with-profile4_5=yes

make get-monolite-latest > /dev/null
make > /dev/null
sudo make install > /dev/null

MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

# Instalando/atualizando os certificados SSL para habilitar as requisicoes HTTPS futuras
sudo mono  $MOZROOTS --import --machine --sync > /dev/null
yes | sudo mono $CERTMGR -ssl -m "https://www.myget.org" > /dev/null

cd .. > /dev/null
