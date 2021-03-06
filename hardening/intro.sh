#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

[ -d /boot/grub ] || (
  echo "La partition /boot doit être accessible."
  exit 127
)

# source cdir.sh
pushd . >/dev/null
umask 027
# WORKDIR="$(mktemp -d --tmpdir)"
# WORKDIR=$(mktemp -t .hardening-run.XXXXXXXXXX -p "$HOME" -d)
# cd "$WORKDIR"
SCRIPTNAME="$(basename "$0")"
OUTFILE="/$HOME/$SCRIPTNAME-$$.txt"
# Exit on error
set -e
exec > >(tee "${OUTFILE}") 2>&1

function harde_error() {
  echo "harde: ERROR: $*"
}
function harde_backup_file() {
  # cp file $1 to $1.YYYY-mm-dd.X
  [ ! -e "$1" ] && return 3
  local EXT
  local i
  i=0
  while :
  do
    i=$((i + 1 ))
    EXT=".-$(date +'%Y-%m-%d').$i"
    [ ! -e "$1${EXT}" ] && break
  done
  cp "$1" "$1${EXT}"
  chmod 0400 "$1${EXT}"
  return 0
}

function copy_se_labels() {
  # copy SElinux labels from $1 to $2
  # use copy_se_labels /var/www /srv/www(/.*)?
  semanage fcontext --modify --equal "$1" "$2" || true
  restorecon -R "$2"
}

# To use the DVD, if available
if [ ! -e /media/media.repo ]; then
  echo -n "Est-ce que le DVD d'installation est dans le lecteur ? "
  read -e -i "O" -r YORN
  if [ ! "${YORN}" = "n" ]; then
    findmnt /media >/dev/null 2>&1 && mount -o ro /dev/sr0 /media
    cat >/etc/yum.repos.d/rhel8.dvd.repo <<EOF
[InstallMedia-BaseOS]			      
name=Red Hat Enterprise Linux 8 - BaseOS
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///media/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[InstallMedia-AppStream]
name=Red Hat Enterprise Linux 8 - AppStream
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///media/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
  fi
fi
if [ ! -e /media/media.repo ]; then
  echo "Le disque d'installation est requis pour l'exécution de ce script."
  exit 1
fi
