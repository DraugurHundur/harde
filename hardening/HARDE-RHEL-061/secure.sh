echo "HARDE-RHEL-61 : S'assurer que le serveur LDAP est désactivé"
systemctl --now disable slapd || true
# Fin: HARDE-RHEL-61
