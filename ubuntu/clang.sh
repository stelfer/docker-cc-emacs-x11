
set -uex

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key > llvm.key
apt-key add < llvm.key

apt-add-repository "deb http://apt.llvm.org/$DIST_VER/ llvm-toolchain-$DIST_VER-$CLANG_VER main"
apt-get update -y ; apt-get upgrade -y
apt-get install -y \
    llvm-$CLANG_VER \
    clang-$CLANG_VER \
    clangd-$CLANG_VER \
    clang-tidy-$CLANG_VER \
    libstdc++-${GCC_VER}-dev \
    libasan6

update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-$CLANG_VER 50
update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-$CLANG_VER 50
update-alternatives --install /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-$CLANG_VER 50
update-alternatives --install /usr/bin/llvm-addr2line llvm-addr2line /usr/bin/llvm-addr2line-$CLANG_VER 50


