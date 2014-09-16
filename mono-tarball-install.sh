#!/bin/sh

PWD=`pwd`
PACKAGE_NAME="mono-3.8.0"
URL_TARBALL="http://download.mono-project.com/sources/mono/$PACKAGE_NAME.tar.bz2"
PREFIX="$PWD/$PACKAGE_NAME-bin"
MONOEXEC=$PREFIX/bin/mono
MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

mkdir -p $PREFIX

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
make install

export PATH=$PATH:$PREFIX/bin

echo "Compressing [Mono] binary..."

echo "tar -zcvf $PACKAGE_NAME-bin.tar.gz $PREFIX"
tar -zcvf "$PACKAGE_NAME-bin.tar.gz" "$PREFIX"

echo "tar -tjvf $PACKAGE_NAME-bin.tar.bz2"
tar -tjvf "$PACKAGE_NAME-bin.tar.bz2"

echo "tar -tvf $PACKAGE_NAME-bin.tar.bz2"
tar -tvf "$PACKAGE_NAME-bin.tar.bz2"

#$MONOEXEC --version

echo "Updating SSL certificates..."
mono $MOZROOTS --import --sync
#sudo $MONOEXEC  $MOZROOTS --import --machine --sync
yes | mono $CERTMGR -ssl "https://www.myget.org"
#yes | sudo $MONOEXEC $CERTMGR -ssl -m "https://www.myget.org"
cd ..
