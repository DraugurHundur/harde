echo "HARDE-RHEL-70 : S'assurer que le service Samba  est désactivé"
systemctl --now disable smb || true
# Fin: HARDE-RHEL-70
