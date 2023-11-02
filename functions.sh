build_ninja() {
    TMPDIR=$1
    BINDIR=$2
    git clone https://github.com/ninja-build/ninja.git $TMPDIR

    cd $TMPDIR
    git checkout release
    ./configure.py --bootstrap
    install -t $BINDIR $TMPDIR/ninja

    # Required by cmake 3.28.1 ...
    ln -sf $BINDIR/ninja /usr/bin
    rm -r $TMPDIR
}
