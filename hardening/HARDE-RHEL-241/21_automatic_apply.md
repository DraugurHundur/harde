
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-241 :

``` {.bash .numberLines}
#! /usr/bin/env bash
echo "HARDE-RHEL-241 : S'assurer de la permission des fichiers journaux"
# this is a one time solution since systemd resets permissions on reboot
#   find /var/log -type f -exec chmod g-wx,o-rwx "{}" + -o -type d -exec chmod g-w,o-rwx "{}" ";"
# systemd way:
sed -e 's,d /var/log 0755,d /var/log 0751,' -i /usr/lib/tmpfiles.d/var.conf
sed -e 's,f /var/log/wtmp 0664,f /var/log/wtmp 0640,' -i /usr/lib/tmpfiles.d/var.conf
sed -e 's,f /var/log/lastlog 0664,f /var/log/lastlog 0640,' -i /usr/lib/tmpfiles.d/var.conf
sed -e 's,f /var/log/btmp 0660,f /var/log/btmp 0640,' -i /usr/lib/tmpfiles.d/var.conf
sed -e 's,z /var/log/journal 2755,z /var/log/journal 2750,' -i /usr/lib/tmpfiles.d/systemd.conf
sed -e 's,z /var/log/journal/%m 2755,z /var/log/journal/%m 2750,' -i /usr/lib/tmpfiles.d/systemd.conf
# Fin: HARDE-RHEL-241
```

