#!/bin/bash

set -e

# Install Protobuf 4.25.3
pushd /tmp
git clone --progress --verbose --recurse-submodules --jobs=$(nproc) --branch=25.x https://github.com/protocolbuffers/protobuf.git
pushd protobuf/
git checkout 4a2aef570deb2bfb8927426558701e8bfc26f2a4 
cmake . -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_BUILD_LIBPROTOC=ON -DABSL_BUILD_TESTING=OFF -Dprotobuf_BUILD_SHARED_LIBS=ON -DABSL_PROPAGATE_CXX_STD=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make -j$(nproc)
make install
ldconfig

popd
rm -rf protobuf
popd

# Build Protobufjson
make clean
make

# Install Protobufjson
rm -rf /usr/bin/{ProtoToJson,JsonToProto,JsonToHeader} 
cp ProtoToJson /usr/bin/ 
cp JsonToProto /usr/bin/ 
ln -s -r /usr/bin/JsonToProto /usr/bin/JsonToHeader




