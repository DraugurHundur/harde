echo "HARDE-RHEL-72 : S'assurer que le serveur HTTP est désactivé"
systemctl --now disable httpd || true
# Fin: HARDE-RHEL-72
