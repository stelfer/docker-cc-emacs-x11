
#
# Add a deb repo, makes sure we don't use the DEPRECATED add-key
#
add_repo () {
    KEY_URL=$1
    KEYRING=$2
    SOURCES=$3
    REP=${@:4}

    wget -O - $KEY_URL 2>/dev/null | gpg --dearmor - | tee $KEYRING > /dev/null
    echo "deb [signed-by=$KEYRING] $REP" | tee $SOURCES >/dev/null

}
