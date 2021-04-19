echo "HARDE-RHEL-177 : S'assurer que les permissions sur /etc/passwd soient correctes"
chown root:root /etc/passwd
chmod 644 /etc/passwd
# Fin: HARDE-RHEL-177
