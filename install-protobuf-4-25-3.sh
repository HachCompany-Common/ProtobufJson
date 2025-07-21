#!/bin/bash

cd /tmp
git clone --progress --verbose --recurse-submodules --jobs=$(nproc) --branch=25.x https://github.com/protocolbuffers/protobuf.git
cd /tmp/protobuf
git checkout 4a2aef570deb2bfb8927426558701e8bfc26f2a4 
cmake . -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_BUILD_LIBPROTOC=ON -DABSL_BUILD_TESTING=OFF -Dprotobuf_BUILD_SHARED_LIBS=ON -DABSL_PROPAGATE_CXX_STD=ON ..
make -j$(nproc)
sudo make install
sudo ldconfig
