echo "HARDE-RHEL-71 : S'assurer que le service IMAP/POP3 est désactivé"
systemctl --now disable dovecot || true
# Fin: HARDE-RHEL-71
