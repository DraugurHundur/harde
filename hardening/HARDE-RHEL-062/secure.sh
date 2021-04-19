echo "HARDE-RHEL-62 : S'assurer que le serveur DHCP est désactivé"
systemctl --now disable dhcpd || true
# Fin: HARDE-RHEL-62
