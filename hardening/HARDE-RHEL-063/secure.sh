echo "HARDE-RHEL-63 : S'assurer que le serveur CUPS est désactivé"
systemctl --now disable cups || true
# Fin: HARDE-RHEL-63
