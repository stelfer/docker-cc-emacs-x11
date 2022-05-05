
set -uex

DIST_VER=focal
TOOLCHAIN_VER=14

#apt-get update -y ; apt-get upgrade -y

apt-get install -y python3-software-properties software-properties-common wget gnupg2
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key > llvm.key
apt-key add < llvm.key

apt-add-repository "deb http://apt.llvm.org/$DIST_VER/ llvm-toolchain-$DIST_VER-$TOOLCHAIN_VER main"
apt-get update -y
apt-get install -y \
    llvm-$TOOLCHAIN_VER \
    clang-$TOOLCHAIN_VER \
    clangd-$TOOLCHAIN_VER \
    cmake \
    libstdc++-10-dev \
    libasan6 git \
    iwyu \
    ccache \
    gdb \
    xxd \
    unzip


update-alternatives --install /usr/bin/c89 c89 /usr/bin/clang-$TOOLCHAIN_VER 50
update-alternatives --install /usr/bin/cc cc /usr/bin/clang-$TOOLCHAIN_VER 50
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-$TOOLCHAIN_VER 50
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-$TOOLCHAIN_VER 50

