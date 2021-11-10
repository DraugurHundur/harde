#! /bin/bash
echo "HARDE-RHEL-018 : S'assurer de la configuration de /var/tmp"
mount | grep -E '/var/tmp\s' | grep nodev | grep noexec | grep nosuid || harde_error "Options de montage non valide pour /var/tmp"
# Fin: HARDE-RHEL-018
