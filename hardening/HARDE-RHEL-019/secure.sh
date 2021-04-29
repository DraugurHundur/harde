#! /usr/bin/env bash
echo "HARDE-RHEL-19 : Partitionnement type"
echo "Les options sur les partitions doivent être positionnées manuellement en suivant le guide"
mkdir /etc/systemd/system/systemd-logind.service.d
# makes systemd-logind work with hidepid
cat >/etc/systemd/system/systemd-logind.service.d/hidepid.conf <<EOF
[Service]
SupplementaryGroups=sudogrp
EOF
# Fin: HARDE-RHEL-19
