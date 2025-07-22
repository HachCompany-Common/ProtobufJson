#!/bin/bash

set -e

# Install Protobuf 3.21.12
pushd /tmp
rm -rf protobuf
git clone --progress --verbose --recurse-submodules --jobs=$(nproc) --branch=21.x https://github.com/protocolbuffers/protobuf.git
pushd protobuf/
git checkout f0dc78d7e6e331b8c6bb2d5283e06aa26883ca7c
./autogen.sh
./configure
make -j$(nproc)
make install
ldconfig

popd
popd

