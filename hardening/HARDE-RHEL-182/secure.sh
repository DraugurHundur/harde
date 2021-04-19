echo "HARDE-RHEL-182 : S'assurer que les permissions sur /etc/shadow- soient correctes"
chown root:root /etc/shadow-
chmod u-x,go-rwx /etc/shadow-
# Fin: HARDE-RHEL-182
