
ARG DIST_VER=focal
FROM ubuntu:$DIST_VER
ARG DIST_VER
ARG TOOLCHAIN_VER=13

RUN apt-get update -y ;\
    apt-get upgrade -y

RUN apt-get install -y python3-software-properties software-properties-common wget gnupg2

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key > llvm.key
RUN apt-key add < llvm.key

ARG DIST_VER
RUN apt-add-repository "deb http://apt.llvm.org/$DIST_VER/ llvm-toolchain-$DIST_VER-$TOOLCHAIN_VER main"
RUN apt-get update -y
RUN apt-get install -y \
    llvm-$TOOLCHAIN_VER \
    clang-$TOOLCHAIN_VER \
    clangd-$TOOLCHAIN_VER \
    cmake \
    libstdc++-10-dev \
    libasan6 git \
    iwyu \
    ccache \
    gdb \
    xxd


RUN update-alternatives --install /usr/bin/c89 c89 /usr/bin/clang-$TOOLCHAIN_VER 50
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-$TOOLCHAIN_VER 50
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-$TOOLCHAIN_VER 50
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-$TOOLCHAIN_VER 50

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
