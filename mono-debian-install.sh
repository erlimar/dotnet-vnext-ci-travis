#!/bin/bash

PREFIX="/usr/local"

sudo apt-get install wget git autoconf libtool automake build-essential gettext

PATH=$PREFIX/bin:$PATH
git clone git://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1

cd mono
./autogen.sh --prefix=$PREFIX \
	--with-mcs-docs=no \
	--with-xammac=no \
	--with-monotouch=no \
	--with-monodroid=no \
	--with-profile2=yes \
	--with-profile4=yes \
	--with-profile4_5=yes

make get-monolite-latest
make
sudo make install

mono --version

ls $PREFIX/lib
ls $PREFIX/lib/mono
ls $PREFIX/lib/mono/4.5

MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

# Instalando/atualizando os certificados SSL para habilitar as requisicoes HTTPS futuras
sudo mono  $MOZROOTS --import --machine --sync
yes | sudo mono $CERTMGR -ssl -m "https://www.myget.org"
