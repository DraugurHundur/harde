echo "HARDE-RHEL-57 : S'assurer que le serveur FTP est désactivé"
systemctl --now disable vsftpd || true
# Fin: HARDE-RHEL-57
