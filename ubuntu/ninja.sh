#!/bin/bash

set -uex

. ./functions.sh

TMPDIR=/tmp/ninja-build
BINDIR=/usr/local/bin

apt-get update -y
apt-get install -y re2c

build_ninja $TMPDIR $BINDIR

