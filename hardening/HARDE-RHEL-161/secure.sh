echo "HARDE-RHEL-161 : S'assurer que les permissions sur /etc/crontab soient correctes"
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
# Fin: HARDE-RHEL-161
