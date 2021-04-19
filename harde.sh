#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

function usage {
        echo "./$(basename $0) [-h] | [-v] <command>"
        echo ' Hardens/checks a Red Hat Enterprise Linux 8.x system.'
        echo ''
        echo 'COMMANDS'
        echo ' secure       Runs the commands required to secure the system.'
        echo ' audit        Audits the system.'
        echo ' gendoc       Generates the PDF and html version of the documentation.'
        echo ' help'        Displays this message.
        echo ''
        echo 'GENERAL OPTIONS'
        echo ' -h           shows usage'
        echo ' -v           enable debugging output'
}

export LANG=C
BATS_VERSION="1.3.0"


function check_required_command() {
    command -v "$1" >/dev/null 
        if  [ $? -eq 1 ] ; then
            echo "$1 is required to install bats-core and run the audit."
            [ -n "$2" ] && exit "$2"
        fi 
}

# harde.md: generated from the harde/HARDE-RHEL-XXX/files
# harde.sh
# hardening/intro.md
# hardening/intro.sh
# hardening/HARDE-RHEL-XXX/00_intro.md
# hardening/HARDE-RHEL-XXX/10_references.md
# hardening/HARDE-RHEL-XXX/secure.sh
# hardening/HARDE-RHEL-XXX/audit.bats
# hardening/HARDE-RHEL-XXX/20_apply.md 
# hardening/HARDE-RHEL-XXX/30_outro.md
# hardening/HARDE-RHEL-XXX/40_local.md
# hardening/outro.sh
# hardening/outro.md
# audit/intro.bats
# reports/<date>/
# list of arguments expected in the input
optstring=":hv"

while getopts ${optstring} arg; do
  case ${arg} in
    h)
      usage
      ;;
    v)
      DEBUG=1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 2
      ;;
  esac
done

case "${1}" in
    secure)
        [ -n "$DEBUG" ] && set -x 
        source hardening/intro.sh
        for f in hardening/HARDE-RHEL-*/secure.sh; do
            source "$f"
        done
        source hardening/outro.sh
        [ -n "$DEBUG" ] && set +x
        ;;
    audit)
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
        ;;
    gendoc)
        # use pandoc to generate the final documentation.
        pandoc hardening/intro.md hardening/HARDE-RHEL-*/*.md hardening/outro.md -f markdown -t html -o harde-doc.html
        ;;
    *)
        usage
        ;;
esac

