echo "HARDE-RHEL-168 : S'assurer que les permissions sur les clés privées d'hôte SSH soient correctes"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chown root:root "{}" ";"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chmod 0600 "{}" ";"
# Fin: HARDE-RHEL-168
