#!/bin/bash -e

VERSION=7.1.1
FILENAME=pypy3.6-$VERSION-beta-linux_x86_64-portable
FILENAME_TAR=$FILENAME.tar.bz2

echo $FILENAME

rm -rf layer
mkdir -p layer
cp bootstrap.py layer/bootstrap
chmod +x layer/bootstrap
cd layer
curl -OL https://bitbucket.org/squeaky/portable-pypy/downloads/$FILENAME_TAR
tar -xvjf $FILENAME_TAR
rm $FILENAME_TAR
mv $FILENAME pypy
cd pypy
(cd bin && ln -s pypy python)
cp /usr/lib/x86_64-linux-gnu/libbz* lib/
cp /usr/lib/x86_64-linux-gnu/libcrypt.so* lib/
zip -r ../../pypy36.zip .
