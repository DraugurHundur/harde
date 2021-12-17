#! /usr/bin/env bash
echo "HARDE-RHEL-19 : Partitionnement type"
cat >/tmp/fs.sed <<EOF
#! /usr/bin/sed
\%^\#%n
#
\%^[-A-Za-z=_/0-9]+ +/ %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  defaults    \5 \6|
\%^[-A-Za-z=_/0-9]+ +/boot %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/0-9]+ +/boot/efi %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/home %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/opt %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/srv %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/tmp %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/usr %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nodev,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/var %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/var/log %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/var/tmp %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^[-A-Za-z=_/]+ +/var/log/audit %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1  \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
\%^proc%cproc       /proc   proc    rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=sudogrp   0 0
\%^[-A-Za-z=_/]+ +/dev/shm %s|([^ ]*) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+) +([^  ]+)|\1   \2  \3  nosuid,nodev,noexec,defaults    \5 \6|
EOF
cp /etc/fstab /etc/fstab.-$(date +'%Y-%m-%d')
sed -Ef /tmp/fstab.sed /etc/fstab > /etc/fstab.new && mv /etc/fstab.new /etc/fstab
mkdir -p /etc/systemd/system/systemd-logind.service.d
# makes systemd-logind work with hidepid
cat >/etc/systemd/system/systemd-logind.service.d/hidepid.conf <<EOF
[Service]
SupplementaryGroups=sudogrp
EOF
# Fin: HARDE-RHEL-19
