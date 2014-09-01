#!/bin/bash

# Instalador do Mono em sistemas Debian

PREFIX=$@

if [ -z $PREFIX ]; then
  PREFIX="/usr/local"
fi

# Garantindo permissao de escrita em $PREFIX
#sudo mkdir $PREFIX
#sudo chown -R `whoami` $PREFIX

# Garantindo que os pacotes necessarios estejam instalados
sudo apt-get install git autoconf libtool automake build-essential gettext #mono-devel

# Clonando, compilando e instalando o Mono em $PREFIX
PATH=$PREFIX/bin:$PATH
git clone https://github.com/mono/mono.git --branch mono-3.8.0-branch --depth 1

cd mono
./autogen.sh --prefix=$PREFIX --with-mcs-docs=no
make get-monolite-latest
make
sudo make install
