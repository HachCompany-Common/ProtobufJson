#!/bin/bash

set -e

# Install Protobuf 4.25.3
pushd /tmp
git clone --progress --verbose --recurse-submodules --jobs=$(nproc) --branch=25.x https://github.com/protocolbuffers/protobuf.git
pushd protobuf/
git checkout 4a2aef570deb2bfb8927426558701e8bfc26f2a4 
cmake . -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_BUILD_LIBPROTOC=ON -DABSL_BUILD_TESTING=OFF -Dprotobuf_BUILD_SHARED_LIBS=ON -DABSL_PROPAGATE_CXX_STD=ON ..
make -j$(nproc)
make install
ldconfig

popd
rm -rf protobuf
popd

# Get protobuf version and informations.
echo -e "\n---------------------------------------------"
echo -e "\t🛠️ Google Protobuf Info"
echo -e "---------------------------------------------"
echo -e "Symlink:\t$(which protoc)\nTarget :\t$(readlink -f $(which protoc))"
echo -e "Version:\t$($(which protoc) --version)"
echo -e "\n"

# Build Protobufjson
make clean
make

# Install Protobufjson
rm -rf /usr/bin/{ProtoToJson,JsonToProto,JsonToHeader} 
cp ProtoToJson /usr/bin/ 
cp JsonToProto /usr/bin/ 
ln -s -r /usr/bin/JsonToProto /usr/bin/JsonToHeader

echo -e "\n-----------------------------"
echo -e "\t📦 Version Info"
echo -e "-----------------------------"
echo -e "ProtoToJson:\t$($(which ProtoToJson) --help 2>&1 | grep '^Version:' | cut -d':' -f2 | xargs)"
echo -e "JsonToProto:\t$($(which JsonToProto) --help 2>&1 | grep '^Version:' | cut -d':' -f2 | xargs)"
echo -e "\n"

