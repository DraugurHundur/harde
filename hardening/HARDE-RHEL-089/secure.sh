echo "HARDE-RHEL-89 : S'assurer que at/cron est restreint aux utilisateurs autorisés"
rm -f /etc/cron.deny
rm -f /etc/at.deny
true >/etc/cron.allow
true >/etc/at.allow
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow
# Fin: HARDE-RHEL-89
