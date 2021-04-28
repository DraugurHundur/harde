#! /usr/bin/env bash
echo "HARDE-RHEL-18 : S'assurer de la configuration de /var/tmp"
mount |grep -E '/var/tmp\s' | grep nodev | grep noexec | grep nosuid || echo "Configuration non valide pour /var/tmp"
# Fin: HARDE-RHEL-18
