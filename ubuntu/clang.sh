#!/bin/bash

set -uex

#
# See https://apt.llvm.org/
#

. ./functions.sh

KEY_URL=https://apt.llvm.org/llvm-snapshot.gpg.key
KEYRING=/usr/share/keyrings/llvm-archive-keyring.gpg
SOURCES=/etc/apt/sources.list.d/llvm.list
REP="http://apt.llvm.org/$DIST_VER/ llvm-toolchain-$DIST_VER-$CLANG_VER main"

add_repo $KEY_URL $KEYRING $SOURCES $REP

apt-get update -y ; apt-get upgrade -y

apt-get install -y \
    llvm-$CLANG_VER \
    clang-$CLANG_VER \
    clangd-$CLANG_VER \
    clang-tools-$CLANG_VER \
    libstdc++-${GCC_VER}-dev \
    libasan6

update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-$CLANG_VER 50
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$CLANG_VER 50
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$CLANG_VER 50
update-alternatives --install /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-$CLANG_VER 50
update-alternatives --install /usr/bin/llvm-addr2line llvm-addr2line /usr/bin/llvm-addr2line-$CLANG_VER 50
update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-$CLANG_VER 50


