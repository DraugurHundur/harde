#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

#set -e
#set -x
export LANG=C
BATS_VERSION="1.3.0"
pushd . >/dev/null

function check_required_command() {
    command -v "$1" >/dev/null 
        if  [ $? -eq 1 ] ; then
            echo "$1 is required to install bats-core and run the audit."
            [ -n "$2" ] && exit "$2"
        fi 
}


# If bats not installed install it
check_required_command bats
if [ $? -eq 1 ]; then
    check_required_command tar 2
    # /tmp may be noexec
    SRCDIR=$(mktemp -d --tmpdir)
    set -e
    if [ ! -e ./bats-core-$BATS_VERSION.tar.gz  ]; then
        check_required_command curl 3
        curl --silent --location https://github.com/bats-core/bats-core/archive/v$BATS_VERSION.tar.gz --output "$SRCDIR/bats-core-$BATS_VERSION.tar.gz" 
	    cp "$SRCDIR/bats-core-$BATS_VERSION.tar.gz" .
    fi
    if [ ! -e ./bats-core-$BATS_VERSION.tar.gz  ]; then
        echo "bats-core version $BATS_VERSION is required to run the audit."
        exit 3
    fi
    tar zxvof bats-core-$BATS_VERSION.tar.gz 
    cd bats-core-$BATS_VERSION
    bash ./install.sh /usr/local
    cd -
    export PATH=/usr/local/bin:$PATH
    hash -r
fi
# bats does not run files from TMPDIR but just to be sure
# /tmp is likely noexec so store files elsewhere
TMPDIR=$(mktemp -t .audit-run.XXXXXXXXXX -p "$HOME" -d)
export TMPDIR
bats audit/audit.bats
# to keep temporary file comment out the next line and 
#  add --no-cleanup-tempdir to the previous line
rm -rf "$TMPDIR"
popd >/dev/null