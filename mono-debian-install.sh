#!/bin/bash

PREFIX="/usr/local"

echo "Instalando ferramentas..."
sudo apt-get install wget git autoconf libtool automake build-essential gettext > /dev/null 2>&1

PATH=$PREFIX/bin:$PATH
echo "Fazendo download do codigo no GitHub..."
git clone git://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1 > /dev/null 2>&1

cd mono > /dev/null
echo "Preparando a compilacao..."
./autogen.sh --prefix=$PREFIX \
	--with-mcs-docs=no \
	--with-xammac=no \
	--with-monotouch=no \
	--with-monodroid=no \
	--with-profile2=no \
	--with-profile4=yes \
	--with-profile4_5=yes \
	> /dev/null 2>&1

echo "Fazendo download do MonoLite..."
make get-monolite-latest > /dev/null 2>&1

echo "Iniciando compilacao do Mono..."
travis_wait
make > /dev/null 2>&1

echo "Instalando o Mono..."
sudo make install > /dev/null 2>&1

MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

echo "Atualizando certificados SSL..."
sudo mono  $MOZROOTS --import --machine --sync > /dev/null 2>&1
yes | sudo mono $CERTMGR -ssl -m "https://www.myget.org" > /dev/null 2>&1

echo ""
echo "Preparacao do Mono finalizada!"
echo ""

cd .. > /dev/null
