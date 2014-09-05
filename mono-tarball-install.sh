#!/bin/sh

PACKAGE_NAME="mono-3.8.0"
URL_TARBALL="http://download.mono-project.com/sources/mono/$PACKAGE_NAME.tar.bz2"
PREFIX="/usr/local"
MOZROOTS="$PREFIX/lib/mono/4.5/mozroots.exe"
CERTMGR="$PREFIX/lib/mono/4.5/certmgr.exe"

echo "PACKAGE_NAME=$PACKAGE_NAME"
echo "URL_TARBALL=$URL_TARBALL"
echo "PREFIX=$PREFIX"
echo "MOZROOTS=$MOZROOTS"
echo "CERTMGR=$CERTMGR"

# Installing prerequisites...
sudo apt-get install wget git autoconf libtool automake build-essential gettext

# Downloading...
wget $URL_TARBALL

# Extracting...
tar -xjvf "$PACKAGE_NAME.tar.bz2"
cd $PACKAGE_NAME

# Configuring...
./configure --prefix=$PREFIX \
    --with-mcs-docs=no \
    --with-xammac=no \
    --with-monotouch=no \
    --with-monodroid=no \
    --with-profile2=no \
    --with-profile4=yes \
    --with-profile4_5=yes

# Compiling...
make

# Installing...
sudo make install

# Updating SSL certificates...
sudo mono  $MOZROOTS --import --machine --sync
yes | sudo mono $CERTMGR -ssl -m "https://www.myget.org"

cd ..
