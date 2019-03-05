#!/bin/bash

# Download
curl -v -O -L -b oraclelicense=accept-securebackup-cookie -o jaf-1_1_1.zip http://download.oracle.com/otn-pub/java/jaf/1.1.1/jaf-1_1_1.zip

# Extract files
unzip jaf-1_1_1.zip
mv jaf-1.1.1 "$PREFIX/jaf-1.1.1"

INSTALL_FOLDER=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM

mkdir -p $INSTALL_FOLDER
cp $PREFIX/jaf-1.1.1/activation.jar $INSTALL_FOLDER/
ls -lt $INSTALL_FOLDER
