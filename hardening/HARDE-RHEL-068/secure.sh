echo "HARDE-RHEL-68 : S'assurer que le serveur SNMP est désactivé"
systemctl --now disable snmpd || true
# Fin: HARDE-RHEL-68
