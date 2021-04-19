echo "HARDE-RHEL-162 : S'assurer que les permissions sur /etc/cron.hourly soient correctes"
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
# Fin: HARDE-RHEL-162
