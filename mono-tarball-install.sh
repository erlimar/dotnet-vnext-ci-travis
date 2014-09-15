#!/bin/sh

PWD=`pwd`
PACKAGE_NAME="mono-3.8.0"
URL_TARBALL="http://download.mono-project.com/sources/mono/$PACKAGE_NAME.tar.bz2"
#PREFIX="/usr/local"
PREFIX="$PWD/$PACKAGE_NAME-bin"
MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

echo "PWD=$PWD"
echo "PREFIX=$PREFIX"
#echo "PREFIX2=$PREFIX2"

mkdir -R $PREFIX

echo "Installing [Mono] prerequisites..."
sudo apt-get install wget git autoconf libtool automake build-essential gettext > /dev/null 2>&1

echo "Downloading [Mono] tarball..."
wget $URL_TARBALL > /dev/null 2>&1

echo "Extracting [Mono] tarball..."
tar -xjvf "$PACKAGE_NAME.tar.bz2" > /dev/null 2>&1
cd $PACKAGE_NAME

echo "Configuring [Mono]..."
./configure --prefix=$PREFIX \
    --with-mcs-docs=no \
    --with-xammac=no \
    --with-monotouch=no \
    --with-monodroid=no \
    --with-profile2=no \
    --with-profile4=yes \
    --with-profile4_5=yes

echo "Compiling [Mono]..."
make

echo "Installing [Mono]..."
sudo make install > /dev/null 2>&1

echo "Updating SSL certificates..."
sudo mono  $MOZROOTS --import --machine --sync
yes | sudo mono $CERTMGR -ssl -m "https://www.myget.org"

cd ..
