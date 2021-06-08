#! /bin/bash
echo "HARDE-RHEL-127 : S'assurer que la réutilisation d'anciens mots de passe soit limitée"
#
touch /etc/securety/opasswd
chmod 0600 /etc/securety/opasswd
# ls -ldZ /etc/security/opasswd
# -rw-------. root root system_u:object_r:shadow_t:s0 /etc/security/opasswd
#
# La sécurisation est réalisée par HARDE-RHEL-137
# Fin: HARDE-RHEL-127
