#!/bin/bash

sudo apt install -y astyle cmake gcc ninja-build libssl-dev python3-pytest python3-pytest-xdist unzip xsltproc doxygen graphviz python3-yaml valgrind

cd ~/workspace
git clone -b main https://github.com/open-quantum-safe/liboqs.git
cd liboqs

mkdir -p build
cd build
#rm -f -r *

if [ "armv6l" == `uname -m` ]; then
  EXTRAOPTION=-DOQS_PERMIT_UNSUPPORTED_ARCHITECTURE=ON
fi

cmake -GNinja $EXTRAOPTION ..
ninja
