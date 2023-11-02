
#
# Add a deb repo, makes sure we don't use the DEPRECATED add-key
#

. ../functions.sh

add_repo () {
    KEY_URL=$1
    KEYRING=$2
    SOURCES=$3
    REP=${@:4}

    wget -O - $KEY_URL 2>/dev/null | gpg --dearmor - | tee $KEYRING > /dev/null
    echo "deb [signed-by=$KEYRING] $REP" | tee $SOURCES >/dev/null
}

link_ver () {
    GRP=$1
    VER=$2
    PRIO=10${VER}
    update-alternatives --remove $GRP /usr/bin/$GRP-$VER
    update-alternatives --install /usr/bin/$GRP $GRP /usr/bin/$GRP-$VER $PRIO
    update-alternatives --auto $GRP
}


