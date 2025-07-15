#!/bin/bash

cd /tmp
git clone --progress --verbose --recurse-submodules --jobs=$(nproc) --branch=21.x https://github.com/protocolbuffers/protobuf.git
cd /tmp/protobuf
git checkout f0dc78d7e6e331b8c6bb2d5283e06aa26883ca7c
./autogen.sh
./configure
make -j$(nproc)
sudo make install
sudo ldconfig
