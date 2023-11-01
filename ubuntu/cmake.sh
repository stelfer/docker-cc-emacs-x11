#!/bin/bash

set -uex

#
# See https://apt.kitware.com/
#

. ./functions.sh

KEY_URL=https://apt.kitware.com/keys/kitware-archive-latest.asc
KEYRING=/usr/share/keyrings/kitware-archive-keyring.gpg
SOURCES=/etc/apt/sources.list.d/kitware.list

add_repo $KEY_URL $KEYRING $SOURCES "https://apt.kitware.com/ubuntu/ jammy main"

# Uncomment this if you want to track rc candidates
add_repo $KEY_URL $KEYRING $SOURCES "https://apt.kitware.com/ubuntu/ jammy-rc main"

apt-get update -y ; apt-get upgrade -y

apt-get install -y kitware-archive-keyring cmake

