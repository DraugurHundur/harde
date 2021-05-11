#! /bin/bash
echo "HARDE-RHEL-59 : S'assurer que NFS est désactivé"
systemctl --now disable nfs-server || true
# Fin: HARDE-RHEL-59
